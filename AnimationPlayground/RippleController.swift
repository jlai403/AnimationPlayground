//
//  ViewController.swift
//  AnimationPlayground
//
//  Created by Joey Lai on 2015-06-12.
//  Copyright (c) 2015 Joey Lai. All rights reserved.
//

import UIKit

class RippleController: UIViewController {
    
    private let RIPPLE_DURATION = 3.5
    private let MAX_RIPPLE_WIDTH = CGFloat(600)
    private let RIPPLE_COUNT = 3
    
    @IBOutlet weak var circleView: CircleView!
    @IBOutlet weak var avatar: UIButton!

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
            self.ripples.append(newRipple)
            self.view.insertSubview(newRipple, belowSubview: circleView)
        }
    }
    
    func animateRipples() {
        var delay = 0.75
        for ripple in ripples {
            delayedRipple(delay, circleView: ripple, duration: RIPPLE_DURATION, maxWidth: MAX_RIPPLE_WIDTH)
            delay += (0.25)
        }
    }
    
    func delayedRipple(delay: Double, circleView: CircleView, duration: Double, maxWidth: CGFloat) {
        var dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.ripple(circleView, duration: duration, maxWidth: maxWidth, repeat: true)
        }
    }
    
    func ripple(circleView: CircleView, duration:Double, maxWidth: CGFloat, repeat: Bool) {
        circleView.hidden = false
        UIView.animateWithDuration(duration,
            animations: {
                circleView.expandAndFade(maxWidth)
            },
            completion: { finished in
                circleView.reset(circleView.frame.midX, y: circleView.frame.midY)
                if (repeat) {
                   self.ripple(circleView, duration: duration, maxWidth: maxWidth, repeat: repeat)
                } else {
                    circleView.removeFromSuperview()
                }
                
        })
    }
    
    @IBAction func touchRipple(sender: UIButton) {
        var touchRipple = CircleView(frame: self.circleView.frame)
        self.view.insertSubview(touchRipple, belowSubview: circleView)
        ripple(touchRipple, duration: RIPPLE_DURATION, maxWidth: MAX_RIPPLE_WIDTH, repeat: false)
    }
    
}

