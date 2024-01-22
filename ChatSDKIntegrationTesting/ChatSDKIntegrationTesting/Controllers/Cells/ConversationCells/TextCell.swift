//
//  TextCell.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 03/08/2023.
//

import UIKit
import ChatSDK

class TextCell: UITableViewCell {
    
    @IBOutlet weak var senderUserImage: UIImageView!
    @IBOutlet weak var currentUserImage: UIImageView!
    @IBOutlet weak var deliverStatus: UILabel!
    @IBOutlet weak var sendStatus: UILabel!
    @IBOutlet weak var messageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension TextCell {
    
    func config(message: PMessage) {
        setupUI(isSenderMe: message.senderIsMe())
        self.messageText.text = message.text() ?? ""
        self.deliverStatus.text = "isDelivered: \(message.isDelivered() ?? false)"
        self.sendStatus.text = "isSend: \(message.isRead() ?? false)"
        
    }
    
    func setupUI(isSenderMe:Bool) {
        if isSenderMe {
            //right side
            senderUserImage.isHidden = true
            currentUserImage.isHidden = false
        } else {
            //left side
            senderUserImage.isHidden = false
            currentUserImage.isHidden = true
        }
    }
    
}
