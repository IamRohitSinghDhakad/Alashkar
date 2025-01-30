//
//  HomeTableViewCell.swift
//  Alashkar
//
//  Created by Dhakad, Rohit Singh (Cognizant) on 11/05/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgVwCra: UIImageView!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarNumber: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblLastService: UILabel!
    @IBOutlet weak var lblUpdateService: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblNextServiceDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
