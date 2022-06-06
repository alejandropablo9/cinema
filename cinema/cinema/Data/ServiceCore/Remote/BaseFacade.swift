//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Alamofire
public class BaseFacade {
    private var log = Logger(logLevel: .severe)
    var multipartHeaders: HTTPHeaders = ["Content-type": "multipart/form-data"]
    var basicHeaders: HTTPHeaders = ["Content-Type": "application/json"]
    var connection = ManagerService()
    var delegate: FacadeDelegate?
    public func decodeEntity<T: Codable>(responseType: T.Type, data: Data, serviceName: String) {
        if let responseState = self.decode(responseType, from: data, serviceName: serviceName) {
            self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: responseState)
        } else {
            catchError(dataError: data, serviceName: serviceName)
        }
    }
    /// Valida que se realice correctamente la decodificación.
    /// - Parameters:
    ///   - type: Generico T.
    ///   - data: Datos a decodificar.
    ///   - serviceName: Nombre de servicio de la decodificación.
    public func decode<T: Codable>(_ type: T.Type, from data: Data, serviceName: String, decodeError: Bool = false) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            self.log.severe(context)
            if !decodeError {
                catchError(dataError: data, serviceName: serviceName)
            }
        } catch let DecodingError.keyNotFound(key, context) {
            self.log.severe("Key '\(key)' not found:", context.debugDescription)
            self.log.severe("CodingPath:", context.codingPath)
            if !decodeError {
                catchError(dataError: data, serviceName: serviceName)
            }
        } catch let DecodingError.valueNotFound(value, context) {
            self.log.severe("Value '\(value)' not found:", context.debugDescription)
            self.log.severe("CodingPath:", context.codingPath)
            if !decodeError {
                catchError(dataError: data, serviceName: serviceName)
            }
        } catch let DecodingError.typeMismatch(type, context) {
            self.log.severe("Type '\(type)' mismatch:", context.debugDescription)
            self.log.severe("CodingPath:", context.codingPath)
            if !decodeError {
                catchError(dataError: data, serviceName: serviceName)
            }
        } catch {
            self.log.severe("Error: ", error)
            if !decodeError {
                catchError(dataError: data, serviceName: serviceName)
            }
        }
        return nil
    }
    /// Procesa el error de la respuesta recibida.
    /// - Parameters:
    ///   - dataError: Datos que contiene el error.
    ///   - serviceName: Nombre del servicio.
    internal func catchError(dataError: Data, serviceName: String) {
        if let responseFailureMessage = self.decode(ErrorResponseEntity.self, from: dataError, serviceName: serviceName, decodeError: true) {
            self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: responseFailureMessage)
        } else {
            let error = ErrorResponseEntity.init(error: "", errorDescription: "errorGenericService".localized)
            self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: error)
        }
    }
    /// Procesa error que proviene del servidor.
    /// - Parameters:
    ///   - dataError: Strimg que contiene el error.
    ///   - serviceName: Nombre del servicio.
    internal func catchError(dataError: String, serviceName: String) {
        let error = ErrorResponseEntity.init(error: "", errorDescription: "errorGenericService".localized)
        self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: error)
    }
    /// Función que recibe el mensaje de error del servicio
    /// - Parameters:
    ///  - error: Mensaje de error.
    ///  - serviceName: Nombre del servicio.
    func didReceiveError(error: String, serviceName: String) {
        self.catchError(dataError: error, serviceName: serviceName)
    }
}
