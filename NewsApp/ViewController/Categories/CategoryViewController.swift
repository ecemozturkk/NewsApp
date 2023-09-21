
import UIKit

// Protocol to communicate category selection to the parent view
protocol CategorySelectionDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    weak var categorySelectionDelegate: CategorySelectionDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set self as the data source for the TableView
            categoryTableView.dataSource = self
            categoryTableView.delegate = self
        }
        
        // MARK: - UITableViewDataSource Methods
        
        // Return the number of rows for the TableView
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Return the number of categories, for example, there are 7 categories
            return 7
        }
        
        // Provide cells for the TableView
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            
            // Insert category names into the respective cell
            switch indexPath.row {
            case 0:
                cell.categoryNameLabel.text = K.general
            case 1:
                cell.categoryNameLabel.text = K.business
            case 2:
                cell.categoryNameLabel.text = K.science
            case 3:
                cell.categoryNameLabel.text = K.technology
            case 4:
                cell.categoryNameLabel.text = K.health
            case 5:
                cell.categoryNameLabel.text = K.entertainment
            case 6:
                cell.categoryNameLabel.text = K.sports
            default:
                cell.categoryNameLabel.text = "Unknown Category"
            }
            
            return cell
        }
        
        // MARK: - UITableViewDelegate Method
        
        // Get the category name for a given row
        func getCategoryForRow(_ row: Int) -> String {
            switch row {
            case 0:
                return K.general
            case 1:
                return K.business
            case 2:
                return K.science
            case 3:
                return K.technology
            case 4:
                return K.health
            case 5:
                return K.entertainment
            case 6:
                return K.sports
            default:
                return "Unknown Category"
            }
        }
        
        // Handle selection of a category
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Store the selected category in a variable
            let selectedCategory = getCategoryForRow(indexPath.row)
            print("Selected Category: \(selectedCategory)")
            
            // Send a notification to transmit the category information using NotificationCenter
            NotificationCenter.default.post(name: NSNotification.Name("CategorySelectionNotification"), object: selectedCategory)
        }
}
