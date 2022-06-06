//
//  LoginRouter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
final class LoginRouter {
    /// Referencia a la vista
    var view: LoginVC
    /// referencia al presenter
    var presenter: LoginPresenter
    /// Referencia al interactor
    var interactor: LoginInteractor
    /// Constructor de la clase
    init() {
        view = LoginVC.init()
        presenter = LoginPresenter()
        interactor = LoginInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = self
    }
}
extension LoginRouter: LoginRouterProtocol {
    func showMovies() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
            let firstView: UIViewController = MoviesRouter.init().view
            let navigationController = UINavigationController(rootViewController: firstView)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
