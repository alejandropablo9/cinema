//
//  MoviesInteractor.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Network
final class MoviesInteractor {
    /// Referencia al presenter
    var presenter: MoviesOutputInteractorProtocol?
    /// Monitorea el estado de conexión a internet
    let netConnection = NetMonitor.shared
    ///
    let serviceLocal = LocalMovies.init()
}
extension MoviesInteractor: MoviesInputInteractorProtocol {
    func getMovies() {
        switch netConnection.connType {
        case .unknown:
            if let localData = self.serviceLocal.getData().first {
                let urlImg = (localData.routes.filter({$0.code == "poster"}).first?.sizes?.large ?? "").replacingOccurrences(of: "http", with: "https")
                let urlImgHorizontal = (localData.routes.filter({$0.code == "poster_horizontal"}).first?.sizes?.large ?? "").replacingOccurrences(of: "http", with: "https")
                let values = localData.movies.map { movie in
                    return MovieCellEntity.init(name: movie.name, originalName: movie.originalName, synopsis: movie.synopsis, poster: urlImg + (movie.media.filter({$0.code == "poster"}).first?.resources ?? ""), posterH: urlImgHorizontal + (movie.media.filter({$0.code == "poster_horizontal"}).first?.resources ?? ""))
                }.shuffled()
                self.presenter?.requestSuccess(response: values)
            } else {
                self.presenter?.requestFailure(error: "errorGenericService" .localized)
            }
        default:
            let facade = MoviesFacade()
            facade.delegate = self
            facade.getMovies()
        }
    }
}
extension MoviesInteractor: FacadeDelegate {
    func didReceiveEntitySuccess<T>(tagName: String, result: T) where T : Decodable {
        switch (tagName) {
        case MoviesResponse.className:
            if let response = result as? MoviesResponse {
                saveLocalData(response: response)
                let urlImg = (response.routes.filter({$0.code == "poster"}).first?.sizes.large ?? "").replacingOccurrences(of: "http", with: "https")
                let urlImgHorizontal = (response.routes.filter({$0.code == "poster_horizontal"}).first?.sizes.large ?? "").replacingOccurrences(of: "http", with: "https")
                let values = response.movies.map { movie in
                    return MovieCellEntity.init(name: movie.name, originalName: movie.originalName, synopsis: movie.synopsis, poster: urlImg + (movie.media.filter({$0.code == "poster"}).first?.resource ?? ""), posterH: urlImgHorizontal + (movie.media.filter({$0.code == "poster_horizontal"}).first?.resource ?? ""))
                }
                presenter?.requestSuccess(response: values)
            } else if let error = result as? ErrorResponseEntity {
                presenter?.requestFailure(error: error.errorDescription ?? "errorGenericService" .localized)
            } else {
                presenter?.requestFailure(error: "errorGenericService" .localized)
            }
        default: break
        }
    }
}
extension MoviesInteractor {
    func saveLocalData(response: MoviesResponse) {
        let routes = response.routes.compactMap { route in
            return RouteLocal.init(code: route.code, sizes: SizesLocal.init(large: route.sizes.large ?? "", medium: route.sizes.medium, small: route.sizes.small ?? "", xLarge: route.sizes.xLarge ?? ""))
        }
        let movies = response.movies.compactMap { movie in
            return MovieLocal.init(name: movie.name, originalName: movie.originalName, code: movie.code, distributor: movie.distributor, categories: movie.categories, media: movie.media.map({MediaLocal.init(resources: $0.resource, type: $0.type, code: $0.code)}), position: movie.position, synopsis: movie.synopsis)
        }
        let dataMovies = MoviesDataLocal.init(movies: movies, routes: routes)
        _ = serviceLocal.save(data: dataMovies)
    }
}
