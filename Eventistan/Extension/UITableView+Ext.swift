//
//  UITableView+Ext.swift
//  
//
//  Created by Zain Ul Abe Din on 07/10/2024.
//

import Foundation
import UIKit

public extension UITableView {
    func registerCellNib<T: UITableViewCell>(_: T.Type, bundle: Bundle? = nil) {
        let stringRepresentation = String(describing: T.self)
        self.register(UINib(nibName: stringRepresentation, bundle: bundle), forCellReuseIdentifier: T.reuseId)
    }
    
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_: T.Type, bundle: Bundle? = nil) {
        let stringRepresentation = String(describing: T.self)
        self.register(UINib(nibName: stringRepresentation, bundle: bundle), forHeaderFooterViewReuseIdentifier: T.reuseId)
    }
}
