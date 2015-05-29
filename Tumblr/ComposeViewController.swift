//
//  ComposeViewController.swift
//  Tumblr
//
//  Created by Mike Jacobs on 5/27/15.
//  Copyright (c) 2015 Mike Jacobs. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    var originalYs = [CGFloat]()
    
    @IBOutlet var composeButtons: [UIImageView]!
    @IBOutlet weak var nevermindButton: UIImageView!
    @IBOutlet weak var overlayBg: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nevermindButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tappedNevermindButton:"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedNevermindButton(tapGestureRecognizer: UITapGestureRecognizer){
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            // two options for animation.
            // 1. stagger: animates each button with different timing
            // 2. zoom: animates the entire container
//            staggerInComposeButtons()
            zoomInComposeButtons()
            
            // transition view and nevermind button
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                toViewController.view.alpha = 1
                self.nevermindButton.frame.origin.y = toViewController.view.frame.height - self.nevermindButton.frame.height
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {

//            staggerOutComposeButtons()
            zoomOutComposeButtons()
            
            // transition view and nevermind button
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.nevermindButton.frame.origin.y += self.nevermindButton.frame.height
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    func staggerInComposeButtons(){
        for (index, element) in enumerate(self.composeButtons) {
            element.transform = CGAffineTransformMakeTranslation(0, 1000)
            UIView.animateWithDuration(0.1 * Double(index + 1)){
                element.transform = CGAffineTransformIdentity
            }
            
        }
        
    }
    func staggerOutComposeButtons(){
        for (index, element) in enumerate(self.composeButtons) {
            UIView.animateWithDuration(0.2 * Double(index + 1)){
                element.transform = CGAffineTransformMakeTranslation(0, -1000)
            }
        }
        
    }
    func zoomInComposeButtons(){
        self.buttonContainerView.transform = CGAffineTransformMakeScale(10, 10)
        UIView.animateWithDuration(0.3){
            self.buttonContainerView.transform = CGAffineTransformIdentity
        }
    }
    func zoomOutComposeButtons(){
        UIView.animateWithDuration(0.3){
            self.buttonContainerView.transform = CGAffineTransformMakeScale(10, 10)
        }
    }
    
}
