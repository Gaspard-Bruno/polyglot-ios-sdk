//
//  Polyglot.swift
//  Polyglot-sdk
//
//  Created by Ricardo Alves dos Santos on 22/10/2020.
//

import UIKit

typealias PolyglotResponse = [String: [String: String]]

public class Polyglot {
    
    
    private var apiBaseUrl: String

    public required init(key: String, defaultLanguage: String, apiBaseUrl: String) {
        self.apiBaseUrl = apiBaseUrl
        populateTranlationFiles(key: key)
    }
    
    public func populateTranlationFiles(key: String) {
        
        let urlString =  "\(apiBaseUrl)/\(key)/all.json" // multi language
                
        let url = URL(string: urlString)
        var requrl = URLRequest(url: url!)
        requrl.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        requrl.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        requrl.httpMethod = "get"
        
        let task = URLSession.shared.dataTask(with: requrl) { [self] (data, response, error) in
            
            do {
                guard let data = data else {
                    throw(error!)
                }
                let decoder = JSONDecoder()
                if let responseData = try? decoder.decode(PolyglotResponse.self, from: data.encode(to: String.Encoding.utf8)) {
                    
                    DispatchQueue.main.async {
                        for language in responseData.keys {
                            createPlist(language: language, translations: responseData[language]!)
                        }
                    }
                    
                } else if let error = try? decoder.decode(PolyError.self, from: data) {
                    print("\(errorMarker) \(error)")
                } else {
                }
                
            } catch {
                print("\(errorMarker) error-->",error.localizedDescription)
            }
        }
        task.resume()

    }
    
    public func createPlist(language: String, translations: [String: String]) {
        
        let fileManager = FileManager.default
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = "\(documentDirectory)/\(language).plist"

        if !fileManager.fileExists(atPath: path) {
            
            let someData = NSDictionary(dictionary: translations)
            let isWritten = someData.write(toFile: path, atomically: true)
          
            
        } else {
            do {
                try fileManager.removeItem(at: PolyExtensions.getFileURL(language: language))
                let someData = NSDictionary(dictionary: translations)
                someData.write(toFile: path, atomically: true)
            } catch {
                print("\(errorMarker) \(error)")
            }
            
        }
    }
    
    public struct PolyError: Decodable {
        
        public var code: Int
        public var message: String
        
    }
}
