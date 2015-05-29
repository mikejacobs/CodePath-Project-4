//
//  HomeViewController.swift
//  Tumblr
//
//  Created by Mike Jacobs on 5/27/15.
//  Copyright (c) 2015 Mike Jacobs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var spinnerView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var loginForm: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        // rotate the spinner
        UIView.animateWithDuration(5.0, delay:0, options: .Repeat | .CurveLinear, animations: {
            self.spinnerView.transform = CGAffineTransformMakeRotation(-22)
            
            }, completion: nil)
        
        loginButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onLoginTap:"))
        loginForm.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onLoginFormTap:"))

    }
    func onLoginTap(tapGestureRecognizer: UITapGestureRecognizer) {
        // bring in the keyboard
        UIView.animateWithDuration(0.3, animations: {
            self.formView.alpha = 1
            }, completion: {
                (value: Bool) in
                self.textField.becomeFirstResponder()
        })
    }
    
    func onLoginFormTap(tapGestureRecognizer: UITapGestureRecognizer) {
        // dismiss the keyboard and then the view
        self.textField.resignFirstResponder()
        UIView.animateWithDuration(0.3){
            self.formView.alpha = 0
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
