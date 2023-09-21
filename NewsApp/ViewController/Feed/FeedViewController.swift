//
//  FeedViewController.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 10.09.2023.
//

import UIKit
import SideMenu


class FeedViewController: UIViewController {
    
    
    @IBOutlet weak var feedTableView: UITableView! // headlinesTableView
    @IBOutlet weak var searchBar: UISearchBar!
    
    var headlines: [Article] = []
    var currentAPICallPage = 1
    var category: String? = nil
    var searchResults: [Article] = []
    var searchQuery: String? = nil

    var selectedCategory: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sideMenuBtn.target = revealViewController()
        //sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        configureTableView()
        fetchArticles()
       
    }
    
    func configureTableView() {
        view.addSubview(feedTableView)
        feedTableView.dataSource = self
        feedTableView.delegate = self
    }
    
    func fetchArticles(searchQuery: String? = nil) {
        // Specify the category and page number you want to fetch
        let category = "general"
        let pageNumber = "1"

        if let query = searchQuery, !query.isEmpty {
            // Fetch articles based on the search query
            NetworkManager.shared.getSearchArticles(passedInQuery: query) { [weak self] result in
                switch result {
                case .success(let articles):
                    // Update the searchResults array with the fetched articles
                    self?.searchResults = articles!

                    // Reload the table view to display the search results
                    DispatchQueue.main.async {
                        self?.feedTableView.reloadData()
                    }

                case .failure(let error):
                    print(error)
                }
            }
        } else {
            // Fetch articles for the default category and page number
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
    
    @IBAction func categoriesButtonTapped(_ sender: UIBarButtonItem) {
        // Define the menu
        let menu = SideMenuNavigationController(rootViewController: BookmarksViewController() )
        // SideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menu = storyboard!.instantiateViewController(withIdentifier: "RightMenu") as! SideMenuNavigationController
        present(menu, animated: true, completion: nil)
    }
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use searchResults if there are search results, otherwise use headlines
        return searchResults.isEmpty ? headlines.count : searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        
        let article = searchResults.isEmpty ? headlines[indexPath.row] : searchResults[indexPath.row]
        cell.setHeadlines(for: article)
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedArticle = headlines[indexPath.row]
        showFeedDetailViewController(with: selectedArticle)
    }

    func showFeedDetailViewController(with article: Article) {
        let feedDetailVC = FeedDetailViewController(article: article)
        self.navigationController?.pushViewController(feedDetailVC, animated: true)
    }
}


extension FeedViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Call fetchArticles with the search query when the search text changes
        fetchArticles(searchQuery: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search bar and reload the table with default articles
        searchBar.text = nil
        searchResults.removeAll()
        feedTableView.reloadData()
    }
}
