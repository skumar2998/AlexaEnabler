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
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBOutlet weak var textFieldString: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enableButtonPressed(_ sender: UIButton) {
        
        if let skillID = textFieldString.text as String? {
            let deeplinkingString = "alexa://alexa?fragment=skills/dp/\(skillID)"
            let customURL = URL(string: deeplinkingString)!
            
            if UIApplication.shared.canOpenURL(customURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(customURL)
                } else {
                    UIApplication.shared.openURL(customURL)
                }
            } else {
                self.openEmbeddedWebUrl(skillId: skillID)
            }
        }

    }
    
    func openEmbeddedWebUrl(skillId: String) {
        let webVC = SwiftModalWebVC(urlString: "https://www.amazon.com/dp/\(skillId)", theme: .lightBlue, dismissButtonStyle: .cross)
        webVC.isToolbarHidden = true
        self.present(webVC, animated: true, completion: nil)
    }
    
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = 0 - (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
}

