//
//  ViewExtension.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
extension UIView {
    /// Función que regresa el ancho y alto de la vista.
    /// - Returns: regresa una variable de tipo CGSize con el alto y el ancho
    func getSizeView(colums: Int) -> CGSize {
        let width: CGFloat = ((self.frame.size.width) / CGFloat(colums))
        let height: CGFloat = 300
        return CGSize(width: width, height: height)
    }
}
