//
//  MeditationCell.swift
//  Metta
//
//  Created by Novi Gunawan on 10/04/21.
//

import UIKit

class MeditationCell: UITableViewCell {

    @IBOutlet weak var detailCard: UIView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailSessionLabel: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    
    
    @IBOutlet weak var imageCard: UIView!
    @IBOutlet weak var meditationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
