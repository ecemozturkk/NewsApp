//
//  BookmarksTableViewCell.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 18.09.2023.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookmarkLabel: UILabel!
    @IBOutlet weak var bookmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
