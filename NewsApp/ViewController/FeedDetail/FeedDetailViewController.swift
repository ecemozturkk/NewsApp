//
//  FeedDetailViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 15.09.2023.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var seeMoreDetailBtn: UIButton!
    @IBOutlet weak var addToBookmarksBtn: UIButton!
    
    
    var article: Article?
    
    init(article: Article) {
        self.article = article
        super.init(nibName: "FeedDetailViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    @IBAction func seeMoreDetailClicked(_ sender: UIButton) {
    }
    
    
    @IBAction func addToBookmarksClicked(_ sender: UIButton) {
    }
    

}
