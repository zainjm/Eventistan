//
//  UICollectionView+Ext.swift
//  
//
//  Created by Zain Ul Abe Din on 07/10/2024.
//

import Foundation
import UIKit

public extension UICollectionView {
    func registerCellNib<T: UICollectionViewCell>(_: T.Type, bundle: Bundle? = nil) {
        let stringRepresentation = String(describing: T.self)
        self.register(UINib(nibName: stringRepresentation, bundle: bundle), forCellWithReuseIdentifier: T.reuseId)
    }
    
    func registerHeaderFooterNib<T: UICollectionReusableView>(_: T.Type, bundle: Bundle? = nil, forSupplementaryViewOfKind kind: String = UICollectionView.elementKindSectionHeader) {
        let stringRepresentation = String(describing: T.self)
        self.register(UINib(nibName: stringRepresentation, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseId)
    }
}
