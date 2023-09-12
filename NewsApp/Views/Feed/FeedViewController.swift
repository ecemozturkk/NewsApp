//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit

// TableView
// Custom cell
// API Caller
// Open the news story
// Search for news stories

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        NetworkManager.shared.getArticles(passedInCategory: "general", passedInPageNumber: "1") { result in
            switch result {
            case .success(_):
                break
            case .failure(let gotError):
                print(gotError)
            }
        }
//        
//        APICaller.shared.getTopStories { result in
//            switch result {
//            case .success(_):
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "sdnksmdnklasd"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
