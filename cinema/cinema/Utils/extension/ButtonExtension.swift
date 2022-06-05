//
//  ButtonExtension.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
extension UIButton {
    func setStyleColorButton() {
        self.layer.cornerRadius = 5
        self.backgroundColor = .primaryButton
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
