//
//  NSDateExtensions.swift
//  books
//
//  Created by Andrew Bennet on 27/05/2016.
//  Copyright © 2016 Andrew Bennet. All rights reserved.
//

import Foundation
import UIKit

extension NSDate {
    convenience init(dateString: String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let date = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval: 0, sinceDate: date)
    }
    
    func toLongStyleString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .NoStyle
        return formatter.stringFromDate(self)
    }
}

extension CollectionType {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIImage {
    convenience init?(optionalData: NSData?) {
        if let data = optionalData {
            self.init(data: data)
        }
        else {
            return nil
        }
    }
}

extension String {
    /// Return whether the string contains any characters which are not whitespace.
    func isEmptyOrWhitespace() -> Bool {
        return self.trim().isEmpty
    }
    
    /// Removes all whitespace characters from the beginning and the end of the string.
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func toAttributedString(attributes: [String : AnyObject]?) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func toAttributedStringWithFont(font: UIFont) -> NSAttributedString {
        return self.toAttributedString([NSFontAttributeName: font])
    }
    
    func withTextStyle(textStyle: String) -> NSAttributedString {
        return self.toAttributedStringWithFont(UIFont.preferredFontForTextStyle(textStyle))
    }
}

extension NSMutableAttributedString {
    
    static func byConcatenating(withNewline withNewline: Bool, _ attributedStrings: NSAttributedString?...) -> NSMutableAttributedString? {
        // First of all, filter out all of the nil strings
        let notNilStrings = attributedStrings.flatMap{$0}
        
        // Check that there is a first string in the array; if not, return nil
        guard let firstString = notNilStrings[safe: 0] else { return nil }
        
        // Initialise the mutable string with the first string
        let mutableAttributedString = NSMutableAttributedString(attributedString: firstString)
        
        // For all of the other strings (if there are any), append them to the mutable strings
        for attrString in notNilStrings.dropFirst() {
            if withNewline {
                mutableAttributedString.appendNewline()
            }
            mutableAttributedString.appendAttributedString(attrString)
        }
        
        return mutableAttributedString
    }
    
    func appendNewline() {
        self.appendAttributedString(NSAttributedString(string: "\u{2028}"))
    }
}

extension NSPredicate {
    @nonobjc static var TruePredicate = NSPredicate(format: "TRUEPREDICATE")
    
    convenience init(fieldName: String, equalTo: String) {
        self.init(format: "\(fieldName) == \(equalTo)")
    }
    
    convenience init(fieldName: String, containsSubstring: String) {
        self.init(format: "\(fieldName) CONTAINS[cd] \(containsSubstring)")
    }
}