//
//  PolyExtensions.swift
//  Polyglot-sdk
//
//  Created by Ricardo Alves dos Santos on 22/10/2020.
//

import UIKit

class PolyExtensions {
    
    class func fileExists(language: String, fileExtension: String = "plist") -> Bool {
        if let _ = NSDictionary(contentsOf: PolyExtensions.getFileURL(language: language)) as? [String: String] {
            return true
        } else {
            return false
        }
    }
    
    class func getFileURL(language: String, fileExtension: String = "plist") -> URL {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: language, relativeTo: directoryURL).appendingPathExtension(fileExtension)
        return fileURL
    }
    
    class func getFile(language: String) -> [String: String]? {
        
        if let file = isLanguageAvailable(language) {
            return file
        } else {
            let arrayLanguage = language.components(separatedBy: "-")
            if arrayLanguage.count > 1 {
                for lang in arrayLanguage {
                    if let file = isLanguageAvailable(lang) {
                        return file
                    }
                }
            }
        }
        return nil
    }
    
    private class func isLanguageAvailable(_ language: String) -> [String: String]? {
        return NSDictionary(contentsOf: PolyExtensions.getFileURL(language: language)) as? [String: String]
    }
}
