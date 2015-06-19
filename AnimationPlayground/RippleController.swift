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
            var newRipple = CircleView(copy: self.circleView)
            self.ripples.append(newRipple)
            self.view.insertSubview(newRipple, belowSubview: circleView)
        }
    }
    
    func animateRipples() {
        var delay = 0.0
        for ripple in ripples {
            self.ripple(ripple, duration: self.RIPPLE_DURATION, delay: delay, repeat: true)
            delay += 0.25
        }
    }
    
    func ripple(ripple: CircleView, duration: Double, delay: Double, repeat: Bool) {
        ripple.hidden = false
        UIView.animateWithDuration(duration,
            delay: delay,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                var maxRippleWidth = self.MAX_RIPPLE_WIDTH
                var halfEndSize = maxRippleWidth / 2
                var x = ripple.frame.midX
                var y = ripple.frame.midY
                ripple.frame = CGRectMake(x - halfEndSize, y - halfEndSize, maxRippleWidth, maxRippleWidth)
                ripple.alpha = 0
            },
            completion: { finished in
                ripple.reset(self.circleView.frame.midX, y: self.circleView.frame.midY)
                if (repeat) {
                    self.ripple(ripple, duration: duration, delay: 0, repeat: repeat)
                } else {
                    ripple.removeFromSuperview()
                }
                
        })
    }
    
    @IBAction func touchRipple(sender: UIButton) {
        var touchRipple = CircleView(copy: self.circleView)
        self.view.insertSubview(touchRipple, belowSubview: circleView)
        self.ripple(touchRipple, duration: RIPPLE_DURATION, delay: 0, repeat: false)
    }
    
}

