//
//  SessionData.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import Foundation
/// Clase para manterner algunos datos persistentes.
final class SessionData: NSObject {
    /// Función para almacenar la información del usuario.
    /// - Parameter user: Entidad con la información del login
    public static func saveLoginData(user: LoginResponse) {
        do {
            let jsonEncoder = JSONEncoder()
            let data = try jsonEncoder.encode(user)
            let jsonString = String(data: data, encoding: .utf8)
            UserDefaults.standard.set(jsonString, forKey: Constants.KeysUserDefaults.kUser)
        } catch {
            #if DEBUG
            print("Error al salvar los datos de usuario LoginResponse")
            #endif
        }
    }
    /// Función para obtener la información adicional del usuario.
    /// - Returns: Retorna la información del usuario
    internal static func getAditionaInfoData() -> LoginResponse {
        let userInfo = LoginResponse.init()
        if let stringData = UserDefaults.standard.object(forKey: Constants.KeysUserDefaults.kUser) as? String {
            guard let codyUser = stringData.data(using: .utf8) else {
                return userInfo
            }
            do {
                let jsonDecoder = JSONDecoder()
                let userLoginData = try jsonDecoder.decode(LoginResponse.self, from: codyUser)
                return userLoginData
            } catch {
                #if DEBUG
                print(error.localizedDescription)
                dump(error)
                #endif
                return userInfo
            }
        }
        return userInfo
    }
    /// Función que elimina la información persistente del usuario.
    public static func deleteUserData() {
        let preferences: UserDefaults = UserDefaults.standard
        if let bundleID = Bundle.main.bundleIdentifier {
            preferences.removePersistentDomain(forName: bundleID)
        }
    }
}

