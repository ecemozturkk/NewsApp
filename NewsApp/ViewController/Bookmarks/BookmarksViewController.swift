//
//  BookmarksViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit
import Kingfisher

class BookmarksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookmarks: [[String: Any]] = [] // Verilerin saklandığı dizi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        if let storedBookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: Any]] {
            bookmarks = storedBookmarks
        }
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let storedBookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: Any]] {
            bookmarks = storedBookmarks
        }
        
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarksTableViewCell

            let bookmark = bookmarks[indexPath.row]
            cell.bookmarkLabel.text = bookmark["title"] as? String

            // Haber görselini yükle
            if let imageUrlString = bookmark["imageUrl"] as? String, let imageUrl = URL(string: imageUrlString) {
                cell.bookmarkImageView.kf.setImage(with: imageUrl)
            } else {
                // Eğer görsel yoksa, varsayılan bir görsel veya placeholder görsel ayarlayabilirsiniz.
                cell.bookmarkImageView.image = UIImage(named: "placeholderImage")
            }

            return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // İndeks yeterince büyükse, bookmark dizisinden seçilen veriyi alın
        guard indexPath.row < bookmarks.count else {
            return
        }

        let selectedBookmark = bookmarks[indexPath.row]

        // Haber işaretiyle FeedDetailViewController'ı göster
        showFeedDetailViewController(with: selectedBookmark)
    }


    func showFeedDetailViewController(with bookmark: [String: Any]) {
        guard let article = createArticleFromBookmark(bookmark) else {
            return
        }

        let feedDetailVC = FeedDetailViewController(article: article)
        self.navigationController?.pushViewController(feedDetailVC, animated: true)
    }

   
    func createArticleFromBookmark(_ bookmark: [String: Any]) -> Article? {
        guard let title = bookmark["title"] as? String,
              let sourceName = bookmark["sourceName"] as? String,
              let publishedAt = bookmark["publishedAt"] as? String,
              let content = bookmark["content"] as? String,
              let urlToImage = bookmark["imageUrl"] as? String else {
            return nil // Eğer gereken veriler eksikse, nil döndürün.
        }
        
        // Source oluşturun
        let source = Source(id: nil, name: sourceName)

        // Article nesnesini oluşturun ve doldurun
        let article = Article(
            source: source,
            author: nil,
            title: title,
            description: nil,
            url: nil,
            urlToImage: urlToImage,
            content: content,
            publishedAt: publishedAt
        )
        
        return article
    }


}
