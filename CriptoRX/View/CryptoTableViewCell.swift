//
//  CryptoTableViewCell.swift
//  CriptoRX
//
//  Created by Hatice Taşdemir on 7.11.2024.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var item : Crypto! {
        didSet{
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }

}
