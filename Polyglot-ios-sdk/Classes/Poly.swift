//
//  Poly.swift
//  Polyglot-sdk
//
//  Created by Ricardo Alves dos Santos on 22/10/2020.
//

import UIKit

typealias LocalizedDictionary = [String: String]

public class Poly: NSObject {
    
    public static var manager = Poly()
    
    private var polyglot: Polyglot?
    private var defaultLanguage: String?
    private var translations: LocalizedDictionary?
    private var currentLanguage: String {
        let deviceLanguage = Bundle.main.preferredLocalizations.first!
        if defaultLanguage != nil {
            return defaultLanguage!
        } else {
            return deviceLanguage
        }
    }
    
    
    public func loadTranslations(key: String, defaultLanguage language: String) {
        defaultLanguage = language
        polyglot = Polyglot(key: key, defaultLanguage: language)
    }
    
    public func getTranslation(key: String, language: String?) -> String {
        var translation: LocalizedDictionary = [:]
        
        if let file = PolyExtensions.getFile(language: language ?? currentLanguage) {
            translation = file
        } else {
            print("[Polyglot] File Not Found")
            return key
        }

        return translation[key] ?? key
    }
    
}
