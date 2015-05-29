//
//  SearchViewController.swift
//  Tumblr
//
//  Created by Mike Jacobs on 5/27/15.
//  Copyright (c) 2015 Mike Jacobs. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var loader: UIImageView!
    @IBOutlet weak var searchView: UIImageView!
    var loaderCount = 1
    var loadingTimer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchView.alpha = 0
        
        // set timer to swap out loader images
        loadingTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        // set timer to show search view
        NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("removeTimer"), userInfo: nil, repeats: false)

    }
    func removeTimer() {
        self.loadingTimer.invalidate()
        UIView.animateWithDuration(0.3){
            self.loader.alpha = 0
            self.searchView.alpha = 1
        }
    }
    func update() {
        loaderCount = (loaderCount++ % 3) + 1
        loader.image = UIImage(named: "loading-\(loaderCount)")
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
