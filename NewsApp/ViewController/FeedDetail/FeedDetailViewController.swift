//
//  FeedDetailViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 15.09.2023.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    //MARK: -OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var seeMoreDetailBtn: UIButton!
    @IBOutlet weak var addToBookmarksBtn: UIButton!
    
    
    //MARK: - Properties
    var article: Article?
    
    //MARK: - Initialization
    init(article: Article) {
        self.article = article
        super.init(nibName: "FeedDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - UI Configuration
    func configureUI() {
        guard let article = article else { return }

        titleLabel.text = article.title
        sourceLabel.text = article.source.name
        dateLabel.text = DateFormatter.formattedDate(from: article.publishedAt)
        contentLabel.text = article.content
        
        //MARK: Load Image
        if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
            imageView.kf.setImage(with: imageUrl)
        } else {
            imageView.image = UIImage(named: "onboarding1") // Placeholder görseli
        }
    }
    
    //MARK: - Button Actions
    @IBAction func seeMoreDetailClicked(_ sender: UIButton) {
        if let article = article, let url = article.url {
             let webKitViewController = FeedDetailWebKit()
             webKitViewController.url = url
             navigationController?.pushViewController(webKitViewController, animated: true)
         }
     }
    
    @IBAction func addToBookmarksClicked(_ sender: UIButton) {
        guard let article = article else { return }
            var bookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: Any]] ?? []

            if isArticleAlreadyBookmarked(article, in: bookmarks) {
                makeAlert(titleInput: "Warning", messageInput: "New is already added in bookmarks.")
                return
            }

            var articleData: [String: Any] = [
                "title": article.title ?? "Article Title",
                "sourceName": article.source.name ?? "Article Source Name",
                "publishedAt": article.publishedAt ?? "Article Published At",
                "content": article.content ?? "Article Content"
            ]

            // Görselin URL'sini kaydet
            articleData["imageUrl"] = article.urlToImage ?? ""

            bookmarks.append(articleData)

            UserDefaults.standard.set(bookmarks, forKey: "bookmarks")
            UserDefaults.standard.synchronize()

            // Buton metnini güncelle
            //addToBookmarksBtn.setTitle("Added to your bookmarks", for: .normal)

            makeAlert(titleInput: "Success", messageInput: "New is added to your bookmarks.")
}
    
    //MARK: - Helper Functions
    // Haber daha önce eklenip eklenmediğini kontrol etmek için bir fonksiyon
    func isArticleAlreadyBookmarked(_ article: Article, in bookmarks: [[String: Any]]) -> Bool {
        for bookmark in bookmarks {
            if let title = bookmark["title"] as? String, title == article.title {
                return true
            }
        }
        return false
    }
}
