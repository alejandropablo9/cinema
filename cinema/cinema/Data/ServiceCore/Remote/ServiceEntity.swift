//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
open class BaseEntity: Encodable, Decodable {
}
open class ErrorResponseEntity: Codable, ClassDescribing {
    /// Mensaje recibido del servicio.
    public var error: String?
    /// Mensajes de error en formularios.
    public var errorDescription: String?
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        /// Error
        case error
        /// Descripción
        case errorDescription = "error_description"
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(error, forKey: .error)
        try container.encode(errorDescription, forKey: .errorDescription)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.error = try values.decodeIfPresent(String.self, forKey: .error)
        self.errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
    }
    /// Constructor de la clase
    public init(error: String, errorDescription: String) {
        self.error = error
        self.errorDescription = errorDescription
    }
}
