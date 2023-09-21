//
//  UIView+Extension.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 6.09.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat { // @IBInspectable makes this feature editable in Interface Builder
        get { return self.cornerRadius}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
