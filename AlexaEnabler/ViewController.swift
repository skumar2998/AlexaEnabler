//
//  ViewController.swift
//  AlexaEnabler
//
//  Created by Kumar, Sunil on 26/05/18.
//  Copyright © 2018 AppScullery. All rights reserved.
//

import UIKit
import SwiftWebVC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enableButtonPressed(_ sender: UIButton) {
        let customURL = URL(string: "alexa://alexa?fragment=skills/dp/B01N1ZVI7M")!
        
        if UIApplication.shared.canOpenURL(customURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(customURL)
            } else {
                UIApplication.shared.openURL(customURL)
            }
        } else {
            self.openEmbeddedWebUrl()
        }
    }
    
    func openEmbeddedWebUrl() {
        let webVC = SwiftModalWebVC(urlString: "https://www.amazon.com/dp/B01N1ZVI7M", theme: .lightBlue, dismissButtonStyle: .cross)
        webVC.isToolbarHidden = true
        self.present(webVC, animated: true, completion: nil)
    }
    
}

