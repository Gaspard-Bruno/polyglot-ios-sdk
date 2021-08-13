//
//  Poly_String++.swift
//  Polyglot-sdk
//
//  Created by Ricardo Alves dos Santos on 22/10/2020.
//

import UIKit

public extension String {

    func poly(_ language: String? = nil) -> String {
        Poly.manager.getTranslation(key: self, language: language)
    }
    
}
