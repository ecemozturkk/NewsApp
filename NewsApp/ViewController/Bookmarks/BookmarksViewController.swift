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
    
    
}
