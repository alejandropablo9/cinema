//
//  LoginVC.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Alamofire
struct RequestSettings {
    /// Endpoint
    var url: String
    /// Tipo de request
    var method: HTTPMethod = .get
    /// Parámetros
    var parameters: BaseEntity? = nil
    /// Tipo de codificación
    var encoder: ParameterEncoder = JSONParameterEncoder.default
    /// Cabeceras del request
    var headers: HTTPHeaders = [:]
    /// Interceptor
    var interceptor: RequestInterceptor? = nil
}
