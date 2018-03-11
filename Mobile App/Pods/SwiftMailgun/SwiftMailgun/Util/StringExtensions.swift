//
//  StringExtensions.swift
//  SwiftMailgun
//
//  Created by Christopher Jimenez on 3/7/16.
//  Copyright © 2016 Chris Jimenez. All rights reserved.
//

import Foundation

// MARK: - Extension to remove HTML Attributes from Strings
public extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
