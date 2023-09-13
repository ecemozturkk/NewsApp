//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit


class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var feedTableView: UITableView! // headlinesTableView
    
    var headlines: [Article] = []
        var currentAPICallPage = 1
        var category: String? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configureTableView()
            fetchArticles()
        }
        
        func configureTableView() {
            view.addSubview(feedTableView)
            feedTableView.dataSource = self
            feedTableView.delegate = self
        }
        
        func fetchArticles() {
            // Specify the category and page number you want to fetch
            let category = "general"
            let pageNumber = "1"
            
            NetworkManager.shared.getArticles(passedInCategory: category, passedInPageNumber: pageNumber) { [weak self] result in
                switch result {
                case .success(let articles):
                    // Update the headlines array with the fetched articles
                    self?.headlines = articles!
                    
                    // Reload the table view to display the data
                    DispatchQueue.main.async {
                        self?.feedTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return headlines.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
            let article = headlines[indexPath.row]
            cell.setHeadlines(for: article)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
