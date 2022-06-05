//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Enumeración de niveles de registro.
public enum LogLevel: Int {
    /// Nivel nulo, no imprime en consola.
    case none = 0
    /// Información de procesos.
    case verbose = 1
    /// Información para debugear un proceso.
    case debug = 2
    /// Información util.
    case info = 3
    /// Advertencias.
    case warning = 4
    /// Errores.
    case error = 5
    /// Errores severos.
    case severe = 6
    /// Variable para convertir a cadena de texto.
    var toString: String {
        switch self {
        case .none:
            return "None"
        case .verbose:
            return "Verbose"
        case .debug:
            return "Debug"
        case .info:
            return "Info"
        case .warning:
            return "Warning"
        case .error:
            return "Error"
        case .severe:
            return "Severe"
        }
    }
}
extension LogLevel: Comparable {
    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
/// Clase que contiene los metodos de bitacora en consola.
public final class Logger {
    /// Función para configurar BBLog con el nivel deseado.
    ///
    /// - Parameter setting: Entidad delegado.
    public init(logLevel: LogLevel) {
        self.minimumLogLevel = logLevel
    }
    /// Variable del tipo de log a imprimir actual.
    private var minimumLogLevel: LogLevel
    // MARK: - Metodos de registros en consola.
    /// Registra mensajes de error en la consola con prefijo [‼️].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func error( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.error {
            print("‼️[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    /// Registra mensajes de información en la consola con prefijo [ℹ️].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func info( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.info {
            print("ℹ️[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    /// Registra mensajes de información en la consola con prefijo [💬].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func debug( _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.debug {
            print("💬[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    /// Registra mensajes de información en la consola con prefijo [🔬].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func verbose( _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.verbose {
            print("🔬[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    /// Registra advertencias de forma detallada en la consola con prefijo [⚠️].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func warning( _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.warning {
            print("⚠️[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    /// Registra advertencias de forma detallada en la consola con prefijo [🔥].
    ///
    /// - Parameters:
    ///   - object: objeto o mensaje que se registrará.
    ///   - filename: nombre de archivo desde donde se realiza el registro.
    ///   - line: número de línea en el archivo desde donde se realiza el registro.
    ///   - column: número de columna del mensaje de registro.
    ///   - funcName: nombre de la función desde donde se realiza el registro.
    public func severe( _ object: Any..., filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if minimumLogLevel >= LogLevel.severe {
            print("🔥[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
        }
    }
    // MARK: - Funciones utiles.
    /// Extraer el nombre del archivo de la ruta del archivo.
    ///
    /// - Parameter filePath: Ruta de archivo completa.
    /// - Returns: Nombre de archivo con extensión.
    private func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last ?? ""
    }
}

