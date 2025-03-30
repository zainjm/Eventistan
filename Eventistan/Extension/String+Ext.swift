//
//  String+Ext.swift
//  
//
//  Created by Zain Ul Abe Din on 07/10/2024.
//

import Foundation
import UIKit

public extension String {
    static let empty = ""
    
    var intValue: Int? {
        Int(self)
    }
    
    var decimalValue: Decimal? {
        Decimal(string: self)
    }
    
    func width(for font: UIFont) -> CGFloat {
        self.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}

    func formatted(with currency: CurrencyType = .pkr) -> String {
        String(format: currency.amountFormat, self)
    }
    
    func isValidCharCount(_ count: Int) -> Bool {
        self.count >= count
    }
    
    func height(with width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        var attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : font
        ]
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return ceil(boundingBox.height)
    }
    
    func formattedDate(from inputFormat: DateFormat, to outputFormat: DateFormat, locale: Locale = .current, timeZone: TimeZone = .current) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat.value
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat.value
        outputFormatter.locale = locale
        outputFormatter.timeZone = timeZone
        
        return outputFormatter.string(from: date)
    }
    
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    /// MARK: Converts a string into an `NSAttributedString` with customizable attributes, including the ability to bold or highlight specific text by changing its font and color.
    ///
    /// - Parameters:
    /// `regularFontStyle` and `regularTextColour`: Set the font style and color for the non-highlighted text. If not provided, the text will retain its existing style and color (either previously set or defined in the storyboard).
    ///
    /// `textAlignment`, `lineHeight`, `lineSpacing`, and `lineBreakMode`: Optional attributes for customizing the alignment, line height, spacing, and line break mode of the text. If not specified, the default values are used.
    ///
    /// `wordsToHighlight`: An array of strings representing the words to be highlighted. Wherever these words appear in the text, their font will be changed to `highlightedTextFont` and their color to `highlightedTextColour`.
    func makeAttributedStringWithBoldText(
        regularFontStyle: UIFont? = nil,
        regularTextColour: UIColor? = nil,
        textAlignment: NSTextAlignment? = nil,
        lineHeight: CGFloat? = nil,
        lineSpacing: CGFloat? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        wordsToHighlight: [String]? = nil,
        highlightedTextFont: UIFont? = nil,
        highlightedTextColour: UIColor? = nil
    ) -> NSAttributedString {
        
        var attributes: [NSAttributedString.Key: Any] = [:]
        
        if let regularFontStyle = regularFontStyle {
            attributes[.font] = regularFontStyle
        }
        
        if let regularTextColour = regularTextColour {
            attributes[.foregroundColor] = regularTextColour
        }
        
        let attributedText = NSMutableAttributedString(string: self, attributes: attributes)
        
        if lineHeight != nil || lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            
            if let textAlignment = textAlignment {
                paragraphStyle.alignment = textAlignment
            }
            
            if let lineBreakMode = lineBreakMode {
                paragraphStyle.lineBreakMode = lineBreakMode
            }
            
            if let lineHeight = lineHeight {
                paragraphStyle.lineHeightMultiple = lineHeight
            }
            if let lineSpacing = lineSpacing {
                paragraphStyle.lineSpacing = lineSpacing
            }
            
            attributedText.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedText.length))
        }
        
        if let wordsToHighlight = wordsToHighlight {
            var boldAttributes: [NSAttributedString.Key: Any] = [:]
            
            if let highlightedTextFont = highlightedTextFont {
                boldAttributes[.font] = highlightedTextFont
            }
            
            if let highlightedTextColour = highlightedTextColour {
                boldAttributes[.foregroundColor] = highlightedTextColour
            }
            
            for word in wordsToHighlight {
                var searchRange = self.startIndex..<self.endIndex
                while let range = self.range(of: word, options: [], range: searchRange) {
                    let nsRange = NSRange(range, in: self)
                    attributedText.addAttributes(boldAttributes, range: nsRange)
                    searchRange = range.upperBound..<self.endIndex
                }
            }
        }
        return attributedText
    }
    
    func htmlToAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
        } catch {
            return nil
        }
    }

    func htmlToPlainText() -> String? {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let plainText = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return plainText?.string ?? self
    }
    
    func width(usingFont font: UIFont) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: attributes)
        return size.width
    }
}


public extension String {
    var phoneWithOutCode: String {
        guard
              let phoneWithOutCode: String? = String(self.dropFirst(3)),
              let phoneWithOutCode else {return .empty}
        return phoneWithOutCode
    }
    
    var getPackageExpireTime : String{
//        let dateFormatter = ISO8601DateFormatter = "yyyy-MM-dd'T'HH:mm:ssXXXXX"()
//        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.ISO8601DateFormatter.rawValue
        // Parse the date string
        if let targetDate = dateFormatter.date(from: self) {
            // Current date
            let currentDate = Date()
            
            // Calculate the difference in seconds
            let timeInterval = targetDate.timeIntervalSince(currentDate)
            
            // Convert to days, weeks, and months (approximation)
            let days = Int(timeInterval / (24 * 60 * 60))
            let weeks = Int(ceil(Double(days) / 7.0))
            let months = Int(ceil(Double(days) / 30.0))
            
            // Print results
            print("Days: \(days)")
            print("Weeks: \(weeks)")
            print("Months: \(months)")
            if months > 0 {
                return "\(months) month\(months.pluralItem)"
            } else if weeks > 0 {
                return "\(weeks) week\(weeks.pluralItem)"
            } else {
                return "\(days) day\(days.pluralItem)"
            }

        } else {
            return .empty
        }
        
    }
    
    
    var getPackageExpireString : String {
        
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: self) else {
            return .empty
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")

        return "Valid till \(dateFormatter.string(from: date))"
    }

}
