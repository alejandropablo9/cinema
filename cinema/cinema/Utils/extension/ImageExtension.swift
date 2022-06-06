//
//  ImageExtension.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
extension UIImageView {
    /// Función para cargar una imagen.
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    /// Función para cargar la imagen desde la url.
    func load(url: String) {
        if let uri = URL.init(string: url) {
            self.load(url: uri)
        }
    }
}
