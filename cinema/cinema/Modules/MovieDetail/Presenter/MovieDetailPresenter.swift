//
//  MovieDetailPresenter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 06/06/22.
//
final class MovieDetailPresenter {
    /// Referencia a la vista
    var view: MovieDetailViewProtocol?
    /// Referencia al router
    var router: MovieDetailRouterProtocol?
}
extension MovieDetailPresenter:  MovieDetailPresenterProtocol {
    func goBack() {
        router?.goBack()
    }
}
