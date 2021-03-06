//
//  Polyglot.swift
//  Polyglot-sdk
//
//  Created by Ricardo Alves dos Santos on 22/10/2020.
//

import UIKit

public class Polyglot {

    public required init(key: String, defaultLanguage: String) {
        populateTranlationFiles(key: key)
    }
    
    public func populateTranlationFiles(key: String) {
        
        let urlString = "https://cdn.polyglot.cloud/c81e728d9d4c2f636f067f89cc14862c/\(key)/all.json" // multi language
                
        let url = URL(string: urlString)
        var requrl = URLRequest(url: url!)
        requrl.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content_type")
        requrl.httpMethod = "get"
        
        let task = URLSession.shared.dataTask(with: requrl) { [self] (data, response, error) in
            
            do {
                guard let data = data else {
                    throw(error!)
                }
                let decoder = JSONDecoder()
                if let responseData = try? decoder.decode([String: [String: String]].self, from: data) {
                    print(responseData)
                    DispatchQueue.main.async {
                        for language in responseData.keys {
                            createPlist(language: language, translations: responseData[language]!)
                        }
                    }
                    
                } else if let error = try? decoder.decode(PolyError.self, from: data) {
                    print(error)
                } else {
                }
                
            } catch {
                print("error-->",error.localizedDescription)
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
            print("is the file created: \(isWritten)")
            
        } else {
            do {
                try fileManager.removeItem(at: PolyExtensions.getFileURL(language: language))
                let someData = NSDictionary(dictionary: translations)
                someData.write(toFile: path, atomically: true)
            } catch {
                print(error)
            }
            
        }
    }
    
    public struct PolyError: Decodable {
        
        public var code: Int
        public var message: String
        
    }
}
