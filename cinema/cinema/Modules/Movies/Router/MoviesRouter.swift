//
//  MoviesRouter.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class MoviesRouter {
    /// Referencia a la vista
    var view: MoviesVC
    /// Referencia al presenter
    private var presenter: MoviesPresenter
    /// Referencia al interactor
    private var interactor: MoviesInteractor
    /// Constructor de la clase
    init() {
        view = MoviesVC.init()
        presenter = MoviesPresenter()
        interactor = MoviesInteractor()
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = self
    }
}
extension MoviesRouter: MoviesRouterProtocol {
}
