//
//  MoviesInteractor.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class MoviesInteractor {
    /// Referencia al presenter
    var presenter: MoviesOutputInteractorProtocol?
}
extension MoviesInteractor: MoviesInputInteractorProtocol {
    func getMovies() {
        let facade = MoviesFacade()
        facade.delegate = self
        facade.getMovies()
    }
}
extension MoviesInteractor: FacadeDelegate {
    func didReceiveEntitySuccess<T>(tagName: String, result: T) where T : Decodable {
        switch (tagName) {
        case MoviesResponse.className:
            if let response = result as? MoviesResponse {
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
