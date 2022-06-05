//
//  BaseViewController.swift
//  cinema
//
//  Created by Jesus Alejandro Pablo Ojeda on 05/06/22.
//
import UIKit
import JGProgressHUD
import SwiftMessages
class BaseViewController: UIViewController {
    /// **UIView** que se desea ser visible cuando se muestra el teclado.
    var viewToShow: UIView!
    /// Variable que determina cuanto se debe de mover la vista.
    var delta: CGFloat = 0.0
    /// Variable para guardar la posición original de la vista.
    var originCenter: CGPoint?
    /// Bandera para establecer si el navigation bar debe de mostrarse.
    var isNavigationControllerHiden = false
    /// Bandera para establecer si el teclado contiene toolbar.
    var viewToSuscribeContainsToolbar = true
    /// Bandera que dice si el teclado está visible.
    var isShowingKeyboard = true
    /// Progress animation
    var progressHUD = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        self.setHideNavigationController(isNavigationControllerHiden)
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originCenter = self.view.center
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    /// Función que regresa la navegación a la vista raíz.
    @objc func popAllView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    /// Función que regresa la navegación una pantalla atrás.
    @IBAction func back() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    /// Función que oculta la vista actual cuando fue mostrado mediante un present modally.
    @IBAction func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    /// Método para ocultar el teclado.
    func dissmissKeyBoard() {
        self.view.endEditing(true)
    }
    /// Función que oculta el teclado al hacer tap dentro de la vista.
    func setTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    /// Función objetivo para ocultar teclado
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    /// Función para ocultar o mostrar el navcontroller.
    /// - Parameter hide: Indica si se oculta o muestra el navcontroller.
    func setHideNavigationController(_ hide: Bool) {
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    /// Función para accionar cuando es pulsado el botón done
    @objc open func donePressed(_ sender: UIBarButtonItem) {
        dissmissKeyBoard()
    }
    /// Función para mostrar la animación del progress.
    func showHUD() {
        self.progressHUD.show(in: self.view, animated: true)
    }
    /// Función para ocultar la animación del progress.
    func hideHUD() {
        self.progressHUD.dismiss(afterDelay: 0.1, animated: true)
    }
    /// Función para mostrar el toast
    /// - Parameters:
    ///  - message: Texto del mensaje.
    ///  - style: Tipo de estilo del toast.
    func showToast(message: String, style: StyleToast) {
        var color: UIColor = .blueColor
        switch style {
        case .failure:
            color = .failureColor
        case .success:
            color = .successColor
        case .info:
            color = .infoColor
        }
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .viewController(self)
        config.presentationStyle = .top
        //var location: Loaf.Location = .bottom
        let messageView: MessageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureContent(title: "", body: message.localized)
        messageView.button?.isHidden = true
        messageView.iconLabel?.isHidden = true
        messageView.iconImageView?.isHidden = true
        messageView.configureTheme(backgroundColor: color, foregroundColor: .white)
        messageView.configureDropShadow()
        messageView.configureBackgroundView(width: view.bounds.width-32)
        SwiftMessages.show(config: config, view: messageView)
    }
    /// Método para mostrar el teclado.
    /// - Parameter notification: Objeto tipo **NSNotification** con la información de la notificación.
    @objc func keyboardWillShow(notification: NSNotification) {
        if viewToShow == nil {
            return
        }
        let userInfo = notification.userInfo
        let kbSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        if let viewBounds = self.viewToShow?.bounds {
            let relativeFrame = self.viewToShow?.convert(viewBounds, to: self.view)
            if let originY = relativeFrame?.origin.y, let sizeHeight = relativeFrame?.size.height, let kbHeight = kbSize?.height {
                let pivote = originY + sizeHeight
                let keyboardSize = viewToSuscribeContainsToolbar ? kbHeight + 70 : kbHeight
                if (self.view.bounds.size.height - keyboardSize) < pivote {
                    UIView.animate(withDuration: 0.3, animations: {
                        let auxDelta = self.delta
                        if let height = self.view?.bounds.size.height, let centerY = self.view?.center.y, let centerX = self.view?.center.x {
                            self.delta = ((height - keyboardSize)-pivote)
                            if self.isShowingKeyboard {
                                self.view?.center = CGPoint.init(x: centerX, y: centerY + (self.delta-auxDelta))
                            } else {
                                self.view?.center = CGPoint.init(x: centerX, y: centerY + self.delta)
                            }
                            self.isShowingKeyboard = true
                        }
                    })
                } else {
                    self.delta = 0
                    /// si el delta es 0, la vista debe volver a su posición original
                    if let center = originCenter, self.view.center != center {
                        self.view.center = center
                    }
                }
            }
        }
    }
    /// Método para ocultar el teclado.
    ///   - Parameter notification: Objeto tipo **NSNotification** con la información de la notificación.
    @objc func keyboardWillHide(notification: NSNotification) {
        if viewToShow == nil {
            return
        }
        if delta != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                if let width = self.view?.bounds.size.width, let centerY = self.view?.center.y {
                    self.view?.center = CGPoint.init(x: width/2.0, y: centerY - self.delta)
                    self.isShowingKeyboard = false
                }
            })
        }
        /// si el delta es 0, la vista debe volver a su posición original
        if let center = originCenter, self.view.center != center {
            self.view.center = center
        }
        delta = 0
    }
}
