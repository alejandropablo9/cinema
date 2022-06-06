//
//  NetMonitor.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Network
/// Enumeración con los tipos de conexión
public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}
/// Clase que escucha el cambio de estados de la conexión a internet.
class NetMonitor {
    static public let shared = NetMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var connType: ConnectionType = .wifi
    var netOn: Bool = true
    /// Constructor de la clase
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    /// Inicia el monitoreo de los cambios de estado.
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            self.netOn = path.status == .satisfied
            self.connType = self.checkConnectionTypeForPath(path)
        }
    }
    /// Detiene el monitoreo
    func stopMonitoring() {
        self.monitor.cancel()
    }
    /// Regresa el tipo de estado actual.
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        return .unknown
    }
}
