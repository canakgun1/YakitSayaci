//
//  YazıTableViewCell.swift
//  BenzinTakip
//
//  Created by CAN AKGUN on 20.08.2023.
//

import UIKit

class YaziTableViewCell: UITableViewCell {

    @IBOutlet weak var yüzdeLabel: UILabel!
    @IBOutlet weak var araLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
