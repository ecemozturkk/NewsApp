//
//  UIViewController+Extension.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 11.09.2023.
//

import UIKit

extension UIViewController {
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
