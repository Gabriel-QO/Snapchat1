//
//  ViewController.swift
//  Snapchat1
//
//  Created by Mac 10 on 26/05/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FacebookLogin

class IniciarSesionViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var FacebookButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil{
                print("Se presento el siguiente error \(error)")
            }else{
                print("Inicio de sesion exitoso")
            }
        }
    }
    
    @IBAction func FacebookTapped(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], viewController: self) { (result) in
            
            switch result {
            case .success(granted: let granted, declined: let declined, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                
                Auth.auth().signIn(with: credential) { (result, error) in
                    print("Iniciando sesion con Facebook...")
                    if error != nil{
                        print("Se presento el siguiente error \(error)")
                    }else{
                        print("Se inicio sesion con Facebook!!")
                    }
                    
                }
            case .cancelled:
                break
            case .failed(_):
                break
            }
            
        }
        
    }
    
    
}

