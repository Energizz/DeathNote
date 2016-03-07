//
//  CustomCell.swift
//  DeathNote
//
//  Created by Valentin Martin on 26/02/16.
//  Copyright © 2016 Valentin Martin. All rights reserved.
//

import UIKit

class CustomCell : UITableViewCell {

    /* Var */
    
    @IBOutlet weak var cellCircumstance: UILabel!
    @IBOutlet weak var cellDateDeath: UILabel!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    /* Constructeur */
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /* Funcs */
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
