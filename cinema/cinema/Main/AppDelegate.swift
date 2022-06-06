//
//  AppDelegate.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    /// Variable que define la pantalla principal.
    var window: UIWindow?
    /// Variable para hacer referencia a la barra de navegación.
    var navigationController: UINavigationController?
    /// Inicializa el monitorio de conexión.
    let netConnection = NetMonitor.shared
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        netConnection.startMonitoring()
        var viewController: UIViewController?
        if SessionData.getAditionaInfoData().accesToken.isEmpty {
            let router = LoginRouter.init()
            viewController = router.view
        } else {
            let router = MoviesRouter.init()
            viewController = router.view
        }
        if let view = viewController {
            self.navigationController = UINavigationController(rootViewController: view)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        netConnection.stopMonitoring()
    }
}
