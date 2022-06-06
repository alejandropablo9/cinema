//
//  MovieDetailProtocols.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 06/06/22.
//
/// Protocolo de comunicación entre el presenter y la vista
protocol MovieDetailViewProtocol {
}
/// Protocolo de comunicación entre la vista y el presenter
protocol MovieDetailPresenterProtocol {
    /// Función para regresar a la vista anterior
    func goBack()
}
/// Protocolo de comunicación entre el presenter y el router
protocol MovieDetailRouterProtocol {
    /// Función para regresar a la vista anterior
    func goBack()
}
