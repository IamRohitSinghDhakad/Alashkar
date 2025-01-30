//
//  NotificationTableViewCell.swift
//  Alashkar
//
//  Created by Rohit SIngh Dhakad on 04/10/24.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var vwOuter: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblTitleTwo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.vwOuter.addShadow(corner: 6)
        self.vwOuter.cornerRadius = 6
        self.vwOuter.clipsToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
