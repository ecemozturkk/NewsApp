//
//  BookmarksViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit
import Kingfisher

class BookmarksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var bookmarks: [[String: Any]] = [] // An array to store the data
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Load bookmarks from UserDefaults if available
        if let storedBookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: Any]] {
            bookmarks = storedBookmarks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh bookmarks when the view appears
        if let storedBookmarks = UserDefaults.standard.array(forKey: "bookmarks") as? [[String: Any]] {
            bookmarks = storedBookmarks
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkCell", for: indexPath) as! BookmarksTableViewCell
        
        let bookmark = bookmarks[indexPath.row]
        cell.bookmarkLabel.text = bookmark["title"] as? String
        
        // Load the news image
        if let imageUrlString = bookmark["imageUrl"] as? String, let imageUrl = URL(string: imageUrlString) {
            cell.bookmarkImageView.kf.setImage(with: imageUrl)
        } else {
            // Set a default image or placeholder image if there is no image
            cell.bookmarkImageView.image = UIImage(named: "placeholderImage")
        }
        
        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // If the index is valid, retrieve the selected bookmark from the array
        guard indexPath.row < bookmarks.count else {
            return
        }
        
        let selectedBookmark = bookmarks[indexPath.row]
        
        // Show the FeedDetailViewController with the selected bookmark
        showFeedDetailViewController(with: selectedBookmark)
    }
    
    // MARK: - Helper Functions
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
            return nil // Return nil if required data is missing.
        }
        
        // Create a Source object
        let source = Source(id: nil, name: sourceName)
        
        // Create and populate an Article object
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
