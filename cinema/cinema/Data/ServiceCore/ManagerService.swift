//
//  ManagerService.swift
//  zeuz-ios
//
//  Created by Jesus Alejandro Pablo Ojeda on 03/06/22.
//
import Alamofire
open class ManagerService {
    var delegate: MSDelegate?
    var log = Logger(logLevel: .severe)
    /// Función que realizá la petición a los servicios.
    func startRequestConnection(settings: RequestSettings, tagName: String) {
        AF.request(settings.url, method: settings.method, parameters: settings.parameters, encoder: settings.encoder, headers: settings.headers, interceptor: settings.interceptor)
            .responseData { response in
                self.log.debug(response)
                if let error = response.error?.errorDescription {
                    /// Delegar acción ocurrida por la comunicación.
                    self.delegate?.didReceiveError(error: error, serviceName: tagName)
                } else {
                    if let statusCode = response.response?.statusCode, let data = response.value, statusCode >= 200 && statusCode < 300 {
                        /// Delegar acción respuesta exitosa.
                        self.delegate?.didReceiveData(data: data, serviceName: tagName)
                    } else {
                        /// Delegar acción ocurrida por el servidor.
                        self.delegate?.didReceiveError(error: "errorGenericService".localized, serviceName: tagName)
                    }
                }
        }
    }
}
/// Protocolo para el envío de información hacia la aplicación.
protocol FacadeDelegate {
    /// Función que envía las entidades necesarias para manejarlas en la aplicación.
    /// - Parameters:
    ///  - tagName: Nombre del servicio.
    ///  - result: Entidad que regresa la información.
    func didReceiveEntitySuccess<T: Decodable>(tagName: String, result: T)
}
/// Protocolo para el envío de información hacia el Facade.
protocol MSDelegate {
    /// Función que envía la información del servidor.
    /// - Parameter data: Es la información obtenida del servicio.
    /// - Parameter serviceName: Es el identificador del servicio de tipo cadena.
    func didReceiveData(data: Data, serviceName: String)
    /// Función que envía la información del servidor, cuando sucede un error.
    /// - Parameter error: Mensaje del error.
    /// - Parameter serviceName: Es el identificador del servicio de tipo cadena.
    func didReceiveError(error: String, serviceName: String)
}
