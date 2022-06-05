//
//  ColorExtension.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
extension UIColor {
    /// Color de fondo para mensaje exitoso.
    public static let successColor = UIColor(named: "successColor") ?? .green
    /// Color de fondo para mensaje de error.
    public static let failureColor = UIColor(named: "failureColor") ?? .red
    /// Color de fondo para mensaje informativo.
    public static let infoColor = UIColor(named: "infoColor") ?? .blue
    /// Color azul
    public static let blueColor = UIColor(named: "blueColor") ?? .blue
    /// Color boton primario
    public static let primaryButton = UIColor(named: "primaryButton") ?? .purple
}
