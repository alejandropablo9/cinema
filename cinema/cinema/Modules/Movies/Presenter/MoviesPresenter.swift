//
//  MoviesPresenter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class MoviesPresenter {
    /// Referencia al interactor.
    var interactor: MoviesInputInteractorProtocol?
    /// Referencia al router.
    var router: MoviesRouterProtocol?
    /// Referencia a la vista.
    var view: MoviesViewProtocol?
}
extension MoviesPresenter: MoviesPresenterProtocol {
    func getMovies() {
        view?.showHUD()
        interactor?.getMovies()
    }
}
extension MoviesPresenter: MoviesOutputInteractorProtocol {
    func requestSuccess(response: MoviesResponse) {
        view?.hideHUD()
        view?.requestSuccess(response: response)
    }
    func requestFailure(error: String) {
        view?.hideHUD()
        view?.requestFailure(error: error)
    }
}
