//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
final class LoginVC: BaseViewController {
    @IBOutlet fileprivate weak var txtFieldUserName: UITextField!
    @IBOutlet fileprivate weak var txtFieldPassword: UITextField!
    @IBOutlet fileprivate weak var lblWelcome: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    /// Referencia a la vista.
    var presenter: LoginPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setTap()
        btnLogin.setTitle("btn.login".localized, for: .normal)
        btnLogin.setStyleColorButton()
        lblWelcome.text = "lbl.welcome" .localized
        txtFieldUserName.attributedPlaceholder = NSAttributedString(
            string:  "ph.username".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        txtFieldPassword.attributedPlaceholder = NSAttributedString(
            string:  "ph.password".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        txtFieldPassword.keyboardType = .emailAddress
        txtFieldPassword.delegate = self
        txtFieldUserName.delegate = self
    }
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        if let userName = txtFieldUserName.text, let pass = txtFieldPassword.text, !userName.isEmpty && !pass.isEmpty {
            presenter?.doLogin(username: userName.replacingOccurrences(of: "@", with: "%40"), password: pass)
        }
    }
}
extension LoginVC: LoginViewProtocol {
    func requestSuccess(response: LoginResponse) {
        presenter?.showMovies()
    }
    func requestFailure(error: String) {
        showToast(message: error, style: .failure)
    }
}
extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewToShow = textField
        switch textField {
        case txtFieldPassword:
            txtFieldPassword.text = ""
        default: break
        }
    }
    /// Función para comunicar que el botón de "Return" fue presionado.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldNavigation(textField)
        return true
    }
    func textFieldNavigation(_ textField: UITextField) {
        switch textField {
        case txtFieldUserName:
            txtFieldPassword.becomeFirstResponder()
        case txtFieldPassword:
            dissmissKeyBoard()
        default: break
        }
    }
}
