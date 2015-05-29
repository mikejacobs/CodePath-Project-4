//
//  TabBarViewController.swift
//  Tumblr
//
//  Created by Mike Jacobs on 5/25/15.
//  Copyright (c) 2015 Mike Jacobs. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    
    var viewControllers = [String: UIViewController]()
    var tabBarButtons = [UIButton]()
    var currentButton = UIButton()
    var defaultChildViewController = "Home"
    
    @IBOutlet weak var floater: UIImageView!
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor(red:0x25/255.0, green:0x35/255.0, blue:0x4A/255.0, alpha:0xFF/255.0)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        for view in tabBar.subviews as! [UIView] {
            if let button = view as? UIButton {
                setupTabBarButton(button)
            }
        }
        switchToChildViewController(defaultChildViewController)
        
        UIView.animateWithDuration(2.0, delay:0, options: .Repeat | .Autoreverse, animations: {
            
            self.floater.transform = CGAffineTransformMakeTranslation(0, -10)
            
            }, completion: nil)
        
    }
    
    func setupTabBarButton(button: UIButton){
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        // mostly generalized, but janky, way of associating tab bar button with viewcontroller
        if let text = button.titleLabel?.text {
            // if the button doesnt have a label, ignore it
            if (text.isEmpty){
                return
            }
            
            button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedTabBarButton:"))
            tabBarButtons.append(button)
            
            if text == defaultChildViewController {
                currentButton = button
                currentButton.selected = true
            }
            
            println("Added \(text) view controller")
            var vc = storyboard.instantiateViewControllerWithIdentifier(text) as! UIViewController
            addChildViewController(vc)
            vc.view.frame = contentView.bounds
            viewControllers[text] = vc
            
        }
    }
    
    func tappedTabBarButton(tapGestureRecognizer: UITapGestureRecognizer){
        if let button = tapGestureRecognizer.view as? UIButton{
            
            if currentButton == button{
                return
            }
            
            currentButton.selected = false
            button.selected = true
            currentButton = button
            
            if let storyboardId = button.titleLabel?.text {
                println("\(storyboardId) button tapped")
                switchToChildViewController(storyboardId)
            }
        }
    }
    
    func switchToChildViewController(storyboardId: String){
        println("Switched to \(storyboardId)")
        var vc = viewControllers[storyboardId]
        contentView.addSubview(vc!.view)
        vc!.view.alpha = 0
        
        if storyboardId == "Search" {
            UIView.animateWithDuration(0.3, delay:0,
                options:.BeginFromCurrentState,
                animations: {
                    self.floater.transform = CGAffineTransformMakeTranslation(0, -50)
                    self.floater.alpha = 0
                }, completion:nil)
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            vc!.view.alpha = 1
            }) { (Bool) -> Void in
                vc!.didMoveToParentViewController(self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
