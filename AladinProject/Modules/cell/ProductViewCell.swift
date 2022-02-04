//
//  ProductViewCell.swift
//  AladinProject
//
//  Created by Irfan Adika on 03/02/22.
//

import UIKit

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var descProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    static var cellName = "productCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
