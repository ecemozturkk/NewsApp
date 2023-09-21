
import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            // TableView'nin veri kaynağı olarak self'i ayarla
            categoryTableView.dataSource = self
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
}
