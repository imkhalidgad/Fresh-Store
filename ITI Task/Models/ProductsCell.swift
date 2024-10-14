//
//  ProductsCell.swift
//  ITI Task
//

import UIKit

class ProductsCell: UITableViewCell {

    @IBOutlet weak var productIMGInCell: UIImageView!
    @IBOutlet weak var productNameInCell: UILabel!
    @IBOutlet weak var productRatingInCell: UILabel!
    @IBOutlet weak var productPriceInCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
