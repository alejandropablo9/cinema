//
//  MoviesFacade.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Alamofire
final class MoviesFacade: BaseFacade {
    public func getMovies() {
        let settings = RequestSettings.init(url: HttpEndPoints.Cinema.movies, method: .get, parameters: nil, encoder: JSONParameterEncoder.default, headers: ["api_key":"stage_HNYh3RaK_Test"], interceptor: nil)
        self.connection.delegate = self
        self.connection.startRequestConnection(settings: settings, tagName: MoviesResponse.className)
    }
}
extension MoviesFacade: MSDelegate {
    func didReceiveData(data: Data, serviceName: String) {
        switch serviceName {
        case MoviesResponse.className:
            self.decodeEntity(responseType: MoviesResponse.self, data: data, serviceName: MoviesResponse.className)
        default:
            let error = ErrorResponseEntity.init(error: "", errorDescription: "errorGenericService".localized)
            self.delegate?.didReceiveEntitySuccess(tagName: serviceName, result: error)
        }
    }
}
