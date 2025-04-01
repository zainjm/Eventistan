//
//  UICollectionViewCell+Ext.swift
//  Extensions
//
//  Created by Zain Ul Abe Din on 28/01/2025.
//

import UIKit

public extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        var view = superview
        while (view != nil && (view as? UICollectionView) == nil) {
            view = view?.superview
        }
        return view as? UICollectionView
    }
}
