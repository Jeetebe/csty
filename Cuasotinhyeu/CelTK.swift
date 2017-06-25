//
//  CelTK.swift
//  Cuasotinhyeu
//
//  Created by MacBook on 6/25/17.
//  Copyright © 2017 Jeetebe. All rights reserved.
//
import UIKit

class CellTK: UITableViewCell
{

    @IBOutlet weak var lbchude: UILabel!
    @IBOutlet weak var lbsinger: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //lbchude.sizeToFit()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
