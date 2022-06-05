//
//  LoginRouter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
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
    }
}
