//
//  CartViewCellTableViewCell.swift
//  AladinProject
//
//  Created by Irfan Adika on 04/02/22.
//

import UIKit

class CartViewCellTableViewCell: UITableViewCell {
    
    static let cellName = "CartCell"

    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var btnMin: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var titleProduct: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
