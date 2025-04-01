//
//  UILabel+Ext.swift
//  Extensions
//
//  Created by Mehnoor on 25/10/2024.
//

import UIKit
import Foundation

public extension UILabel {
    func highlight(text: String?, font: UIFont? = nil, color: UIColor? = nil, _ addParagraphStyle: Bool = false, options: NSString.CompareOptions = .caseInsensitive, lineHeightMultiple: CGFloat = 1.25, lineBreakMode: NSLineBreakMode? = nil, alignment: NSTextAlignment? = nil) {
         guard let fullText = self.text, let target = text else {
             return
         }

         let attribText = NSMutableAttributedString(string: fullText)
         let range: NSRange = attribText.mutableString.range(of: target, options: options)
         
        self.lineBreakMode = .byWordWrapping
        
         var attributes: [NSAttributedString.Key: Any] = [:]
         if let font = font {
             attributes[.font] = font
         }
         if let color = color {
             attributes[.foregroundColor] = color
         }
         if addParagraphStyle {
             let paragraphStyle = NSMutableParagraphStyle()
             paragraphStyle.lineHeightMultiple = lineHeightMultiple
             if let lineBreakMode {
                 paragraphStyle.lineBreakMode = lineBreakMode
             }
             if let alignment {
                 paragraphStyle.alignment = alignment
             }
             attribText.addAttributes([.paragraphStyle: paragraphStyle],range: attribText.mutableString.range(of: fullText, options: .caseInsensitive))
         }
         
         attribText.addAttributes(attributes, range: range)
         self.attributedText = attribText
     }
    
    func add(lineHeight: CGFloat, alignment: NSTextAlignment = .natural, lineBreakMode: NSLineBreakMode = .byTruncatingTail){
        guard let text else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineHeightMultiple = lineHeight
        paragraphStyle.lineBreakMode = lineBreakMode
        let attributeString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        attributedText = attributeString
    }
}
