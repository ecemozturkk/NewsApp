
import UIKit

protocol CategorySelectionDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    weak var categorySelectionDelegate: CategorySelectionDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView'nin veri kaynağı olarak self'i ayarla
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
    }
    
    // TableView için satır sayısını döndür
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Kategorilerin sayısını döndür
        return 7 // Örnek olarak 7 kategori var
    }
    
    // TableView hücrelerini döndür
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        
        // Kategori isimlerini ilgili hücreye yerleştir
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
            cell.categoryNameLabel.text = "Bilinmeyen Kategori"
        }
        
        return cell
    }
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
            return "Bilinmeyen Kategori"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Seçilen kategori bilgisini bir değişkende saklayın
        let selectedCategory = getCategoryForRow(indexPath.row)
        print("Seçilen Kategori: \(selectedCategory)")

        // NotificationCenter kullanarak kategori bilgisini iletmek için bir bildirim gönderin
        NotificationCenter.default.post(name: NSNotification.Name("CategorySelectionNotification"), object: selectedCategory)
    }


    
}
