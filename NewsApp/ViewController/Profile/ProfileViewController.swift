//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var switchTheme: UISwitch!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            let darkMode = UserDefaults.standard.bool(forKey: "darkMode")
            switchTheme.isOn = darkMode
        }
        
        if let user = Auth.auth().currentUser {
            if let userEmail = user.email {
                // Kullanıcının e-posta adresi userEmail değişkeninde bulunur.
                // Şimdi bu e-posta adresini ProfileViewController'daki bir label'da gösterebilirsiniz.
                // Örnek olarak, "emailLabel" adında bir label kullanalım:
                emailLabel.text = userEmail
            }
        }
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
    
    @IBAction func switchThemeValueChanged(_ sender: UISwitch) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let appDelegate = windowScene.windows.first {
            UserDefaults.standard.set(sender.isOn, forKey: "darkMode")
            if sender.isOn {
                appDelegate.overrideUserInterfaceStyle = .dark
            } else {
                appDelegate.overrideUserInterfaceStyle = .light
            }
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let appDelegate = windowScene.windows.first {
                UserDefaults.standard.set(sender.isOn, forKey: "darkMode")
                if sender.isOn {
                    appDelegate.overrideUserInterfaceStyle = .dark
                } else {
                    appDelegate.overrideUserInterfaceStyle = .light
                }
            }
        }
    }
}
