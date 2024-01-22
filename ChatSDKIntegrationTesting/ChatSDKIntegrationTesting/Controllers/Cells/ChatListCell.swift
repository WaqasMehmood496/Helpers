//
//  ChatListCell.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 01/08/2023.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var chatId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func config(chatId: String) {
        self.chatId.text = chatId
    }
}
