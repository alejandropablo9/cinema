//
//  LoginEntities.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Clase que representa la petición al servicio
final class LoginRequest: BaseEntity, ClassDescribing {
    /// Código del país.
    public var countryCode: String
    /// Nombre de usuario.
    public var userName: String
    /// Contraseña
    public var password: String
    /// Tipo de contraseña
    public var grantType: String
    /// Cliente
    public var clientId: String
    /// Clave secreta
    public var clientSecret: String
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case userName = "username"
        case password
        case grantType = "grant_type"
        case clientId = "client_id"
        case clientSecret = "client_secret"
    }
    /// Constructor de la clase
    init(contryCode: String, userName: String, password: String, granType: String, clientId: String, clientSecret: String) {
        self.countryCode = contryCode
        self.userName = userName
        self.password = password
        self.grantType = granType
        self.clientId = clientId
        self.clientSecret = clientSecret
        super.init()
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(userName, forKey: .userName)
        try container.encode(password, forKey: .password)
        try container.encode(grantType, forKey: .grantType)
        try container.encode(clientId, forKey: .clientId)
        try container.encode(clientSecret, forKey: .clientSecret)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try values.decode(String.self, forKey: .countryCode)
        userName = try values.decode(String.self, forKey: .userName)
        password = try values.decode(String.self, forKey: .password)
        grantType = try values.decode(String.self, forKey: .grantType)
        clientId = try values.decode(String.self, forKey: .clientId)
        clientSecret = try values.decode(String.self, forKey: .clientSecret)
        try super.init(from: decoder)
    }
}
/// Representa la respuesta del login.
final class LoginResponse: BaseEntity, ClassDescribing {
    public var accesToken: String
    public var expiresIn: Int
    public var tokeyType: String
    public var refreshToken: String
    public var clientId: String
    public var userName: String
    public var contryCode: String
    public var issued: String
    public var expires: String
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case accesToken = "access_token"
        case expiresIn = "expires_in"
        case tokeyType = "token_type"
        case refreshToken = "refresh_token"
        case clientId = "as:client_id"
        case userName = "username"
        case contryCode = "country_code"
        case issued = ".issued"
        case expires = ".expires"
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(accesToken, forKey: .accesToken)
        try container.encode(expiresIn, forKey: .expiresIn)
        try container.encode(tokeyType, forKey: .tokeyType)
        try container.encode(refreshToken, forKey: .refreshToken)
        try container.encode(clientId, forKey: .clientId)
        try container.encode(userName, forKey: .userName)
        try container.encode(contryCode, forKey: .contryCode)
        try container.encode(issued, forKey: .issued)
        try container.encode(expires, forKey: .expires)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accesToken = try values.decode(String.self, forKey: .accesToken)
        expiresIn = try values.decode(Int.self, forKey: .expiresIn)
        tokeyType = try values.decode(String.self, forKey: .tokeyType)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        clientId = try values.decode(String.self, forKey: .clientId)
        userName = try values.decode(String.self, forKey: .userName)
        contryCode = try values.decode(String.self, forKey: .contryCode)
        issued = try values.decode(String.self, forKey: .issued)
        expires = try values.decode(String.self, forKey: .expires)
        try super.init(from: decoder)
    }
}
