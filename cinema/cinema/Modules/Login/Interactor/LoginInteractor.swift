//
//  LoginInteractor.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class LoginInteractor {
    var presenter: LoginOutputInteractorProtocol?
}
extension LoginInteractor: LoginInputInteractorProtocol {
    func doLogin(username: String, password: String) {
        let facade = LoginFacade()
        facade.delegate = self
        facade.postLogin(request: LoginRequest.init(contryCode: Constants.Params.countryCode, userName: username, password: password, granType: Constants.Params.grantType, clientId: Constants.Params.clientID, clientSecret: Constants.Params.clientSecret))
    }
}
extension LoginInteractor: FacadeDelegate {
    func didReceiveEntitySuccess<T>(tagName: String, result: T) where T : Decodable {
        switch (tagName) {
        case LoginResponse.className:
            if let response = result as? LoginResponse {
                presenter?.requestSuccess(response: response)
            } else if let error = result as? ErrorResponseEntity {
                presenter?.requestFailure(error: error.errorDescription ?? "errorGenericService" .localized)
            } else {
                presenter?.requestFailure(error: "errorGenericService" .localized)
            }
        default: break
        }
    }
}
