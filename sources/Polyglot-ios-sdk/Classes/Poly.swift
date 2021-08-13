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
    
    
    public func loadTranslations(key: String, defaultLanguage language: String, apiBaseUrl: String = "https://cdn.polyglot.cloud/c81e728d9d4c2f636f067f89cc14862c") {
        defaultLanguage = language
        polyglot = Polyglot(key: key, defaultLanguage: language, apiBaseUrl: apiBaseUrl)
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
    
    public func changeLanguage(_ language: String) {
        if PolyExtensions.getFile(language: language) != nil {
            defaultLanguage = language
        } else {
            print("[Polyglot] Language not found")
            return
        }
    }
    
}
