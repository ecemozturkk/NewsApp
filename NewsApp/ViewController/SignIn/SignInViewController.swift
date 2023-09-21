//
//  SignInViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 9.09.2023.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        // MARK: Input Validation
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            makeAlert(titleInput: "Error", messageInput: "Please enter your username and password.")
            return
        }
        
        // Password length check
        if password.count < 8 {
            makeAlert(titleInput: "Error", messageInput: "Password must be at least 8 characters long.")
            return
        }
        
        // MARK: Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authData, error in
            guard let self = self else { return }
            
            if let error = error {
                self.makeAlert(titleInput: "Error", messageInput: error.localizedDescription)
            } else if let _ = authData {
                // Navigate to Home View
                let main = UIStoryboard(name: "Home", bundle: nil)
                let home = main.instantiateViewController(withIdentifier: "HomeVC")
                self.present(home, animated: true, completion: nil)
            }
        }
    }
}
