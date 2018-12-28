//
//  ContactTableViewCell.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailIdLabel: UILabel!
    @IBOutlet var personImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
