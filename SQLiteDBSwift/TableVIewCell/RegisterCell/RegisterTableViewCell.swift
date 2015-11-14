//
//  RegisterTableViewCell.swift
//  SQLiteDBSwift
//
//  Created by Hardik Trivedi on 11/11/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

class RegisterTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblEmail: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
