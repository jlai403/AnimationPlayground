//
//  ViewController.swift
//  AnimationPlayground
//
//  Created by Joey Lai on 2015-06-12.
//  Copyright (c) 2015 Joey Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var delayedCircleView: CircleView!
    @IBOutlet weak var searching: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        self.view.bringSubviewToFront(searching)
        animateRipples()
    }
    


    func animateRipples() {
        ripple(circleView, duration: 2.5, maxWidth: CGFloat(600))
        
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.ripple(self.delayedCircleView, duration: 2.5, maxWidth: CGFloat(600))
        }
    }
    
    func ripple(circleView: CircleView, duration:Double, maxWidth: CGFloat) {
        UIView.animateWithDuration(duration,
            animations: {
                var endSize = CGFloat(maxWidth)
                var halfEndSize = endSize/2
                var x = circleView.frame.midX
                var y = circleView.frame.midY
                circleView.frame = CGRectMake(x - halfEndSize, y - halfEndSize, endSize, endSize)
                circleView.alpha = 0
            
            },
            completion: { finished in
                var endSize = CGFloat(100)
                var halfEndSize = endSize/2
                var x = circleView.frame.midX
                var y = circleView.frame.midY
                circleView.frame = CGRectMake(x - halfEndSize, y - halfEndSize, endSize, endSize)
                circleView.alpha = 1.0
                self.ripple(circleView, duration: duration, maxWidth: maxWidth)
        })
    }

}

