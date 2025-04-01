//
//  ReusableCellViewModelType.swift
//
//
//  Created by Zain Ul Abe Din on 10/10/2024.
//

import Foundation

public protocol ReusableCellViewModelType {
    var reuseIdentifier: String { get }
}

public protocol ReusableHeaderFooterViewModelType {
    var reuseIdentifier: String { get }
}

public protocol HeightAdjustableCellViewModelType: ReusableCellViewModelType {
    var height: CGFloat { get }
    func height(in bounds: CGRect) -> CGFloat
}

public extension HeightAdjustableCellViewModelType {
    var height: CGFloat { .zero }
    
    func height(in bounds: CGRect) -> CGFloat { bounds.height }
}

public protocol WidthAdjustableCellViewModelType: ReusableCellViewModelType {
    var width: CGFloat { get }
    func width(in bounds: CGRect) -> CGFloat
}

public extension WidthAdjustableCellViewModelType {
    var width: CGFloat { .zero }
    
    func width(in bounds: CGRect) -> CGFloat { bounds.width }
}

public typealias SizeAdjustableCellViewModelType = HeightAdjustableCellViewModelType & WidthAdjustableCellViewModelType
