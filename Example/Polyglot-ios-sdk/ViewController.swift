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
}

