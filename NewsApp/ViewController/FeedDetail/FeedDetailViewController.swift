//
//  FeedDetailViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 15.09.2023.
//

import UIKit
import Kingfisher

class FeedDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = article {
            titleLabel.text = article.title
            sourceLabel.text = article.source.name
            // Tarih formatını yap
            dateLabel.text = article.publishedAt
            contentLabel.text = article.content
            // Haber görselini yükleme kodu
            if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
                imageView.kf.setImage(with: imageUrl)
            } else {
                // Eğer haber görseli yoksa varsayılan bir görsel veya placeholder görsel ayarlayabilirsiniz.
                imageView.image = UIImage(named: "placeholder_image") // Placeholder görseli
            }
        }
        
    }
    
    
    
    
}
