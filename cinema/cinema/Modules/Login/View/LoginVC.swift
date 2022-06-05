//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
final class LoginVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let facade = LoginFacade()
        facade.delegate = self
        facade.postLogin(request: LoginRequest.init(contryCode: "MX", userName: "pruebas_beto_ia%40yahoo.com", password: "Pruebas01", granType: "password", clientId: "IATestCandidate", clientSecret: "c840457e777b4fee9b510fbcd4985b68"))
    }
}
extension LoginVC: FacadeDelegate {
    func didReceiveEntitySuccess<T>(tagName: String, result: T) where T : Decodable {
        switch (tagName) {
        case LoginResponse.className:
            if let response = result as? LoginResponse {
                print("Success")
            } else if let error = result as? ErrorResponseEntity {
                print("Error")
            } else {
                print("Error1")
            }
        default: break
        }
    }
}
