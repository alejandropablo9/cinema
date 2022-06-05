//
//  LoginProtocols.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
/// Protocolo de comunicación entre el presenter y la vista
protocol LoginViewProtocol {
    /// Función que muestra la animación de carga.
    func showHUD()
    /// Función que oculta la animcaicón de carga.
    func hideHUD()
    /// Indica respuesta exitosa del llamado al servicio.
    func requestSuccess(response: LoginResponse)
    /// Indica respuesta erronea del lllamado al servicio.
    func requestFailure(error: String)
}
/// Protocolo de comunicación entre la vista y el presenter
protocol LoginPresenterProtocol {
    /// Función que llama al servición de login.
    /// - Parameters:
    ///  - username: Nombre de usuario.
    ///  - passoword: Contraseña del usuario.
    func doLogin(username: String, password: String)
    /// Función que muestra la siguiente pantalla.
    func showMovies()
}
/// Protocolo de comunicación entre el interactor y el presenter
protocol LoginInputInteractorProtocol {
    /// Función que llama al servición de login.
    /// - Parameters:
    ///  - username: Nombre de usuario.
    ///  - passoword: Contraseña del usuario.
    func doLogin(username: String, password: String)
}
/// Protocolo de comunicación entre el presenter y el interactor
protocol LoginOutputInteractorProtocol {
    /// Indica respuesta exitosa del llamado al servicio.
    func requestSuccess(response: LoginResponse)
    /// Indica respuesta erronea del lllamado al servicio.
    func requestFailure(error: String)
}
/// Protocolo de comunicación entre el presenter y el router
protocol LoginRouterProtocol {
    /// Función que muestra la siguiente pantalla.
    func showMovies()
}
