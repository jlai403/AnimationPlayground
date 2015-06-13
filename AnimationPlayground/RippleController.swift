//
//  ViewController.swift
//  AnimationPlayground
//
//  Created by Joey Lai on 2015-06-12.
//  Copyright (c) 2015 Joey Lai. All rights reserved.
//

import UIKit

class RippleController: UIViewController {
    
    private let MAX_RIPPLE_WIDTH = CGFloat(600)
    private let RIPPLE_COUNT = 2
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var avatar: UIImageView!

    var ripples: [CircleView]!
    
    override func viewDidLoad() {
        ripples = [CircleView]()
        initAvatar()
    }
    
    private func initAvatar() {
        view.bringSubviewToFront(avatar)
        avatar.layer.cornerRadius = avatar.frame.size.width/2
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = Colors.greenSea.CGColor
    }
    
    override func viewDidAppear(animated: Bool) {
        initRipples()
        animateRipples()
    }
    
    private func initRipples() {
        for (var i = 0; i < self.RIPPLE_COUNT; i++) {
            var newRipple = CircleView(frame: circleView.frame)
            ripples.append(newRipple)
            
            self.view.addSubview(newRipple)
        }
    }
    

    func animateRipples() {
        delayedRipple(0.25, circleView: circleView, duration: 3.5, maxWidth: MAX_RIPPLE_WIDTH)
        
        var delay = 0.75
        for ripple in ripples {
            delayedRipple(delay, circleView: ripple, duration: 3.5, maxWidth: MAX_RIPPLE_WIDTH)
            delay += (0.25)
        }
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

