//
//  UserListCell.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 01/08/2023.
//

import UIKit

class UserListCell: UITableViewCell {

    @IBOutlet weak var userIdLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(user:userModel) {
        self.userIdLabel.text = user.userName
    }
    
}
