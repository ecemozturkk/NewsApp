//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: UIButton) {

        do {
            try Auth.auth().signOut()
            let main = UIStoryboard(name: "Main", bundle: nil)
            let welcome = main.instantiateViewController(withIdentifier: "WelcomeVC")
            self.present(welcome, animated: true, completion: nil)
        } catch {
            print("logout error")
        }
    }
}
