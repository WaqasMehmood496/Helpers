//
//  NoteCell.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 23/05/2023.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(data:NoteTableModel) {
        self.title.text = data.title
        self.detail.text = data.detail
    }
    
}
