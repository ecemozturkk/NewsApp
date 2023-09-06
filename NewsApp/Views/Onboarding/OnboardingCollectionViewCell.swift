//
//  OnboardingCollectionViewCell.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 6.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLbl: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        // Populating the views
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.description
    }
}
