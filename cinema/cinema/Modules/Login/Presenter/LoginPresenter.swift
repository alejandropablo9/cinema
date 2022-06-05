//
//  LoginPresenter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class LoginPresenter {
    /// Referencia a la vista
    var view: LoginViewProtocol?
    /// Referencia al interactor
    var interactor: LoginInputInteractorProtocol?
    /// referencia al router
    var router: LoginRouterProtocol?
}
extension LoginPresenter: LoginPresenterProtocol {
    func doLogin(username: String, password: String) {
        view?.showHUD()
        interactor?.doLogin(username: username, password: password)
    }
    func showMovies() {
        router?.showMovies()
    }
}
extension LoginPresenter: LoginOutputInteractorProtocol {
    func requestSuccess(response: LoginResponse) {
        view?.hideHUD()
        view?.requestSuccess(response: response)
    }
    func requestFailure(error: String) {
        view?.hideHUD()
        view?.requestFailure(error: error)
    }
}
