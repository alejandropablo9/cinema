//
//  StringExtensions.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Foundation
extension String {
    /// Función que encapsula la llamada al archivo Localizable.strings del proyecto.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
