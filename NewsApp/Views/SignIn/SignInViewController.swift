//
//  SignInViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 9.09.2023.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        
        
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter your username and password.")
            return
        }
        
        if password.count < 8 {
            makeAlert(titleInput: "Error", messageInput: "Password must be at least 8 characters long.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authData, error in
            guard let self = self else { return }
            
            if let error = error {
                self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
            } else if let _ = authData {
                let main = UIStoryboard(name: "Home", bundle: nil)
                let home = main.instantiateViewController(withIdentifier: "HomeVC")
                self.present(home, animated: true, completion: nil)
            }
        }
    }
}

