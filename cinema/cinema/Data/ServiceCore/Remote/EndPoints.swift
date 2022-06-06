//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
struct HttpEndPoints {
    /// Url base de la api.
    struct Api {
        static let host: String = "https://stage-api.cinepolis.com/v2"
    }
    /// Endpoints cartelera
    struct Cinema {
        static let login: String = Api.host + "/oauth/token"
        static let movies: String = Api.host + "/movies?country_code=MX&cinema=61"
    }
}

