//
//  MoviesProtocols.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Protocolo de comunicación entre el presenter y la vista
protocol MoviesViewProtocol {
    /// Función que muestra la animación de carga.
    func showHUD()
    /// Función que oculta la animcaicón de carga.
    func hideHUD()
    /// Indica respuesta exitosa del llamado al servicio.
    func requestSuccess(response: [MovieCellEntity])
    /// Indica respuesta erronea del lllamado al servicio.
    func requestFailure(error: String)
}
/// Protocolo de comunicación entre la vista y el presenter
protocol MoviesPresenterProtocol {
    /// Función que llama al servicio para solicitar cartelera
    func getMovies()
}
/// Protocolo de comunicación entre el interactor y el presenter
protocol MoviesInputInteractorProtocol {
    /// Función que llama al servicio para solicitar cartelera
    func getMovies()
}
/// Protocolo de comunicación entre el presenter y el interactor
protocol MoviesOutputInteractorProtocol {
    /// Indica respuesta exitosa del llamado al servicio.
    func requestSuccess(response: [MovieCellEntity])
    /// Indica respuesta erronea del lllamado al servicio.
    func requestFailure(error: String)
}
/// Protocolo de comunicación entre el presenter y el router
protocol MoviesRouterProtocol {
}
