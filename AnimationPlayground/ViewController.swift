//
//  ViewController.swift
//  AnimationPlayground
//
//  Created by Joey Lai on 2015-06-12.
//  Copyright (c) 2015 Joey Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let MAX_RIPPLE_WIDTH = CGFloat(600)
    
    @IBOutlet weak var circleView: CircleView!
    var secondCircleView: CircleView!
    var thirdCircleView: CircleView!
    
    override func viewDidAppear(animated: Bool) {
        initDefaults()
        animateRipples()
    }
    
    private func initDefaults() {
        self.secondCircleView = CircleView(frame: circleView.frame)
        self.secondCircleView.hidden = true
        self.view.addSubview(secondCircleView)

        self.thirdCircleView = CircleView(frame: circleView.frame)
        self.thirdCircleView.hidden = true
        self.view.addSubview(thirdCircleView)
    }
    

    func animateRipples() {
        delayedRipple(0.25, circleView: circleView, duration: 3.5, maxWidth: MAX_RIPPLE_WIDTH)
        delayedRipple(0.75, circleView: secondCircleView, duration: 3.5, maxWidth: MAX_RIPPLE_WIDTH)
        delayedRipple(1.00, circleView: thirdCircleView, duration: 3.5, maxWidth: MAX_RIPPLE_WIDTH)
    }
    
    func delayedRipple(delay: Double, circleView: CircleView, duration: Double, maxWidth: CGFloat) {
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.ripple(circleView, duration: duration, maxWidth: maxWidth)
        }
    }
    
    func ripple(circleView: CircleView, duration:Double, maxWidth: CGFloat) {
        circleView.hidden = false
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
                circleView.reset(circleView.frame.midX, y: circleView.frame.midY)
                self.ripple(circleView, duration: duration, maxWidth: maxWidth)
        })
    }

}

