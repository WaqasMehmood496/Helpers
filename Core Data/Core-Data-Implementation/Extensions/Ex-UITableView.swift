//
//  Ex-UITableView.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 23/05/2023.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        self.register(UINib(nibName: String(describing: T.self), bundle: .main), forCellReuseIdentifier: String(describing: T.self))
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
}
