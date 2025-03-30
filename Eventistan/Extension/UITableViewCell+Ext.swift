//
//  UITableViewCell+Ext.swift
//
//
//  Created by Zain Ul Abe Din on 31/10/2024.
//

import UIKit

public extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while (view != nil && (view as? UITableView) == nil) {
            view = view?.superview
        }
        return view as? UITableView
    }
}
