//
//  StringExtension.swift
//  Assignment
//
//  Created by Abhishek on 17/08/21.
//

import Foundation

extension String {
    func convertSpecialCharacters() -> String {
        var newString = self
        let char_dictionary = [
            "&amp;" : "&",
            "&lt;" : "<",
            "&gt;" : ">",
            "&quot;" : "\"",
            "&apos;" : "'"
        ];
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.literal, range: nil)
        }
        return newString
    }
    
    func trimString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
    }
}
