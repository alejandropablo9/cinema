//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Protocolo interno que regresa el nombre de la clase en forma de texto.
internal protocol ClassDescribing {
    /// Nombre de la clase.
    static var className: String { get }
}
/// Extensión de ClassDescribing que obtiene el nombre de la clase en forma de texto.
extension ClassDescribing {
    /// Nombre de la clase.
    static var className: String {
        return String.init(describing: self)
    }
}
