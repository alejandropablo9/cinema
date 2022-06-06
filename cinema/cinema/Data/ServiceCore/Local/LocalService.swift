//
//  LocalService.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import RealmSwift
class LocalService<T: Object> {
    typealias RealmEntityType = T
    private let realm = try! Realm()
    func save(item: T) throws {
        try realm.write {
            realm.add(item)
        }
    }
    func save(items: [T]) throws {
        try realm.write {
            items.forEach { item in
                realm.add(item, update: .all)
            }
        }
    }
    func update(block: @escaping () -> ()) throws {
        try realm.write() {
            block()
        }
    }
    func delete(item: T) throws {
        try realm.write() {
            realm.delete(item)
        }
    }
    func deleteAll() throws {
        try realm.write() {
            realm.delete(realm.objects(T.self))
        }
    }
    func fetch(predicate: NSPredicate?) -> [T] {
        var objects = realm.objects(T.self)
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects.toArray(ofType: T.self)
    }
    func fetchAll() -> [T] {
        return realm.objects(T.self).toArray(ofType: T.self)
    }
}

