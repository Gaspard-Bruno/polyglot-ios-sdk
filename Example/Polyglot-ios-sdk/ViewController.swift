//
//  ViewController.swift
//  Polyglot-ios-sdk
//
//  Created by Ricardo on 10/22/2020.
//  Copyright (c) 2020 Ricardo. All rights reserved.
//

import UIKit
import Polyglot_ios_sdk

class ViewController: UIViewController {

    @IBOutlet weak var translationLabel: UILabel!
    
    @IBOutlet weak var portugueseButton: UIButton!
    @IBOutlet weak var frenchButton: UIButton!
    @IBOutlet weak var spanishButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateTranslation(_ sender: Any) {
        translationLabel.text = "landing.sdk.ios".poly()
    }
    
    @IBAction func translateToPortuguese(_ sender: UIButton) {
        Poly.manager.changeLanguage("pt")
    }
    
    @IBAction func translateToFrench(_ sender: UIButton) {
        Poly.manager.changeLanguage("fr")
    }
    
    @IBAction func translateToSpanish(_ sender: UIButton) {
        Poly.manager.changeLanguage("es")
    }
    
    @IBAction func translateToEnglish(_ sender: UIButton) {
        Poly.manager.changeLanguage("en-us")
    }
}

