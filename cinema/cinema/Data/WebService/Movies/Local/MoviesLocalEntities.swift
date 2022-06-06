//
//  MoviesLocalEntities.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import RealmSwift
class MoviesDataLocal: Object {
    @Persisted var movies: List<MovieLocal>
    @Persisted var routes: List<RouteLocal>
    convenience init(movies: [MovieLocal], routes: [RouteLocal]) {
        self.init()
        self.movies.append(objectsIn: movies)
        self.routes.append(objectsIn: routes)
    }
}
///
class MovieLocal: Object {
    @Persisted var name: String
    @Persisted var originalName: String
    @Persisted var code: String
    @Persisted var distributor: String
    @Persisted var categories: List<String>
    @Persisted var media: List<MediaLocal>
    @Persisted var position: Int
    @Persisted var synopsis: String
    convenience init(name: String, originalName: String, code: String, distributor: String, categories: [String], media: [MediaLocal], position: Int, synopsis: String) {
        self.init()
        self.name = name
        self.originalName = originalName
        self.code = code
        self.distributor = distributor
        self.categories.append(objectsIn: categories)
        self.media.append(objectsIn: media)
        self.position = position
        self.synopsis = synopsis
    }
}
///
class MediaLocal: Object {
    @Persisted var resources: String
    @Persisted var type: String
    @Persisted var code: String
    convenience init(resources: String, type: String, code: String) {
        self.init()
        self.resources = resources
        self.type = type
        self.code = code
    }
}
///
class CastLocal: Object {
    @Persisted var label: String
    @Persisted var values: List<String>
    convenience init(label: String, values: [String]) {
        self.init()
        self.label = label
        self.values.append(objectsIn: values)
    }
}
///
class RouteLocal: Object {
    @Persisted var code: String
    @Persisted var sizes: SizesLocal?
    convenience init(code: String, sizes: SizesLocal?) {
        self.init()
        self.code = code
        self.sizes = sizes
    }
}
///
class SizesLocal: Object {
    @Persisted var large: String
    @Persisted var medium: String
    @Persisted var small: String
    @Persisted var xLarge: String
    convenience init(large: String, medium: String, small: String, xLarge: String) {
        self.init()
        self.large = large
        self.medium = medium
        self.small = small
        self.xLarge = xLarge
    }
}
