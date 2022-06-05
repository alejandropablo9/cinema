//
//  LoginFacade.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Alamofire
final class LoginFacade: BaseFacade {
    /// Función para consultar la información.
    public func postLogin(request: LoginRequest) {
        let settings = RequestSettings.init(url: HttpEndPoints.Cinema.login, method: .post, parameters: request, encoder: PlainTextEncoder(), headers: ["api_key":"stage_HNYh3RaK_Test"])
        self.connection.delegate = self
        self.connection.startRequestConnection(settings: settings, tagName: LoginResponse.className)
    }
}
extension LoginFacade: MSDelegate {
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case LoginResponse.className:
            self.decodeEntity(responseType: LoginResponse.self, data: data, serviceName: LoginResponse.className)
        default:
            let error = ErrorResponseEntity.init(error: "", errorDescription: "errorGenericService".localized)
            self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: error)
        }
    }
}

