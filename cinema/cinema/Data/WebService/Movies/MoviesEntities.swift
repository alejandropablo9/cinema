//
//  MoviesEntities.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Clase que representa la respuesta de la consulta de cartelera.
final class MoviesResponse: BaseEntity, ClassDescribing {
    /// Lista de peliculas
    public let movies: [Movie]
    /// Lista de rutas
    public let routes: [Route]
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case movies
        case routes
    }
    /// Constructor de la clase
    init(movies: [Movie], routes: [Route]) {
        self.movies = movies
        self.routes = routes
        super.init()
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movies, forKey: .movies)
        try container.encode(routes, forKey: .routes)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decode([Movie].self, forKey: .movies)
        routes = try values.decode([Route].self, forKey: .routes)
        try super.init(from: decoder)
    }
}

/// Representa la pelicula que viene del servicio.
final class Movie: BaseEntity, ClassDescribing {
    /// Calificación
    public let rating: String
    /// Media
    public let media: [Media]
    /// Reparto
    public let cast: [Cast]
    /// Posicion
    public let position: Int
    /// Categoría
    public let categories: [String]
    /// Genero
    public let genre: String
    /// Sinopsis
    public let synopsis: String
    /// Duración
    public let length: String
    /// Lanzamiento
    public let releaseDate: String
    /// Distribuidor
    public let distributor: String
    /// Id
    public let id: Int
    /// Nombre
    public let name: String
    /// Codigo
    public let code: String
    /// Nombre original
    public let originalName: String
    /// Enumeración de llaves.
    enum CodingKeys: String, CodingKey {
        case rating
        case media
        case cast
        case position
        case categories
        case genre
        case synopsis
        case length
        case releaseDate = "release_date"
        case distributor
        case id
        case name
        case code
        case originalName = "original_name"
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rating, forKey: .rating)
        try container.encode(media, forKey: .media)
        try container.encode(cast, forKey: .cast)
        try container.encode(position, forKey: .position)
        try container.encode(categories, forKey: .categories)
        try container.encode(genre, forKey: .genre)
        try container.encode(synopsis, forKey: .synopsis)
        try container.encode(length, forKey: .length)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(distributor, forKey: .distributor)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(code, forKey: .code)
        try container.encode(originalName, forKey: .originalName)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rating = try values.decode(String.self, forKey: .rating)
        media = try values.decode([Media].self, forKey: .media)
        cast = try values.decode([Cast].self, forKey: .cast)
        position = try values.decode(Int.self, forKey: .position)
        categories = try values.decode([String].self, forKey: .categories)
        genre = try values.decode(String.self, forKey: .genre)
        synopsis = try values.decode(String.self, forKey: .synopsis)
        length = try values.decode(String.self, forKey: .length)
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        distributor = try values.decode(String.self, forKey: .distributor)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        code = try values.decode(String.self, forKey: .code)
        originalName = try values.decode(String.self, forKey: .originalName)
        try super.init(from: decoder)
    }
}
/// Representa los recursos de la pelicula
final class Media: BaseEntity, ClassDescribing  {
    let resource: String
    let type: String
    let code: String
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case resource
        case type
        case code
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resource, forKey: .resource)
        try container.encode(type, forKey: .type)
        try container.encode(code, forKey: .code)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resource = try values.decode(String.self, forKey: .resource)
        type = try values.decode(String.self, forKey: .type)
        code = try values.decode(String.self, forKey: .code)
        try super.init(from: decoder)
    }
}
final class Cast: BaseEntity, ClassDescribing {
    let label: String
    let value: [String]
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case label
        case value
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(label, forKey: .label)
        try container.encode(value, forKey: .value)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decode(String.self, forKey: .label)
        value = try values.decode([String].self, forKey: .value)
        try super.init(from: decoder)
    }
}
// MARK: - Route
class Route: BaseEntity, ClassDescribing{
    let code: String
    let sizes: Sizes
    /// Enumeración de llaves.
    public enum CodingKeys: String, CodingKey {
        case code
        case sizes
    }
    /// Constructor de la clase
    init(code: String, sizes: Sizes) {
        self.code = code
        self.sizes = sizes
        super.init()
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(code, forKey: .code)
        try container.encode(sizes, forKey: .sizes)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(String.self, forKey: .code)
        sizes = try values.decode(Sizes.self, forKey: .sizes)
        try super.init(from: decoder)
    }
}

// MARK: - Sizes
class Sizes: BaseEntity, ClassDescribing {
    let large: String?
    let medium: String
    let small: String?
    let xLarge: String?
    /// Enumeración de llaves.
    enum CodingKeys: String, CodingKey {
        case large
        case medium
        case small
        case xLarge = "x-large"
    }
    /// Constructor de la clase
    init(large: String?, medium: String, small: String?, xLarge: String?) {
        self.large = large
        self.medium = medium
        self.small = small
        self.xLarge = xLarge
        super.init()
    }
    /// Codificador de la entidad.
    /// - Parameter encoder: Entidad Encoder.
    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(large, forKey: .large)
        try container.encode(medium, forKey: .medium)
        try container.encode(small, forKey: .small)
        try container.encode(xLarge, forKey: .xLarge)
    }
    /// Inicializador para decodificar.
    /// - Parameter decoder: Entidad Decoder
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decodeIfPresent(String.self, forKey: .large)
        medium = try values.decode(String.self, forKey: .medium)
        small = try values.decodeIfPresent(String.self, forKey: .small)
        xLarge = try values.decodeIfPresent(String.self, forKey: .xLarge)
        try super.init(from: decoder)
    }
}

