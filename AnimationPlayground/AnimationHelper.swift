import UIKit

class AnimationHelper {
    
    func animateElement(duration: Double, source: UIView, destination: UIView, completion: (()-> Void)? = nil) {
        
        var cachedDestination = destination.frame
        
        destination.frame = source.frame
        
        UIView.animateWithDuration(duration,
            animations: {
                destination.frame = cachedDestination
            },
            completion: { finished in
                if let onComplete: ()->Void = completion {
                    onComplete()
                }
            }
        )
    }
    
    func animateImage(duration: Double, source: RoundUIImageView, destination: RoundUIImageView, completion: (()->Void)? = nil) {
        
        destination.image = source.image
        
        var cachedDestination = destination.frame
        destination.frame = source.frame
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = source.layer.cornerRadius
        cornerRadiusAnimation.toValue = cachedDestination.width / 2.0
        cornerRadiusAnimation.duration = duration
        cornerRadiusAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        destination.layer.addAnimation(cornerRadiusAnimation, forKey: "cornerRadius")
        
        UIView.animateWithDuration(duration,
            animations: {
                destination.frame = cachedDestination
            },
            completion: { finished in
                if let onComplete: ()->Void = completion {
                    onComplete()
                }
            }
        )
    }
}