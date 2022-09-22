//
//  HistoryCell.swift
//  CoinConverter
//
//  Created by Jean Lucas Vitor on 22/09/22.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var coinTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(title: String) {
        coinTitleLabel.text = title
    }

}
