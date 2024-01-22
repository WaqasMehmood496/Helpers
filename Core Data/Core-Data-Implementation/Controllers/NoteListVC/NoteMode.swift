//
//  NoteMode.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 23/05/2023.
//

import Foundation

struct NoteTableModel : Codable {
    
    var id : Int = 0
    var title : String = ""
    var detail : String = ""
    var date : Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case detail = "detail"
        case date = "date"
    }
}
