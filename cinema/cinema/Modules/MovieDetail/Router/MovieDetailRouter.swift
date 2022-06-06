//
//  MovieDetailRouter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 06/06/22.
//
final class MovieDetailRouter {
    /// Referencia a la vista
    var view: MovieDetailVC
    /// Referencia al presenter
    var presenter: MovieDetailPresenter
    /// Constructor de la clase
    init() {
        view = MovieDetailVC.init()
        presenter = MovieDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
    }
    /// Constructor de la clase
    convenience init(movie: MovieCellEntity) {
        self.init()
        self.view.movie = movie
    }
}
extension MovieDetailRouter: MovieDetailRouterProtocol {
    func goBack() {
        view.back()
    }
}
