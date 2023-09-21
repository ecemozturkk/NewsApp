//
//  FeedTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 12.09.2023.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var headlineSource: UILabel!
    @IBOutlet weak var headlineImage: UIImageView!
    
    // MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Cell Configuration
    func setHeadlines(for article: Article) {
        // Constraints for the headline label and image view
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        headlineImage.translatesAutoresizingMaskIntoConstraints = false
        headlineImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headlineImage.widthAnchor.constraint(equalTo: headlineImage.heightAnchor, multiplier: 12/9).isActive = true
        
        if let safeTitle = article.title {
            let str = safeTitle.components(separatedBy: " - ")[0] // Remove everything after " - "
            headlineLabel.text = str
        }
        
        if let safeSource = article.source.name {
            headlineSource.text = safeSource
        }
        
        // Configure the image view using Kingfisher
        let processor = RoundCornerImageProcessor(cornerRadius: 40)
        headlineImage.kf.indicatorType = .activity
        print("Image URL -> \(article.urlToImage ?? "IMAGE URL DOESN'T EXIST")")
        if let safeImageURL = article.urlToImage {
            headlineImage.kf.setImage(with: URL(string: safeImageURL), options: [.processor(processor), .transition(.fade(0.2))]) { result in
                switch result {
                case .success(let value):
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.headlineImage.leadingAnchor, constant: -5).isActive = true
                    self.headlineImage.image = value.image
                case .failure(let error):
                    print("NO IMAGE TO SHOW, CAN'T FETCH ERROR: \(error)")
                    self.headlineLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
                }
            }
        }
    }
}

