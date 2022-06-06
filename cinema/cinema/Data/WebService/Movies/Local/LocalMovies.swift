//
//  LocalMovies.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
final class LocalMovies {
    private var localService: LocalService<MoviesDataLocal> = LocalService()
    ///
    public func deleteAll() -> Bool {
        do {
            try localService.deleteAll()
            return true
        } catch {
            return false
        }
    }
    public func save(data: MoviesDataLocal) -> Bool {
        do {
            try localService.save(item: data)
            return true
        } catch {
            return false
        }
    }
    public func getData() -> [MoviesDataLocal] {
        return localService.fetchAll()
    }
}
