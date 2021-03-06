import UIKit

class AnimationHelper {
    
    func animateElement(duration: Double, source: UIView, destination: UIView, completion: (()-> Void)? = nil) {
        
        destination.transform = transformFromRectToRect(from: source.frame, to: destination.frame)
        
        UIView.animateWithDuration(duration,
            animations: {
                destination.transform = CGAffineTransformIdentity
            },
            completion: { finished in
                if let onComplete: ()->Void = completion {
                    onComplete()
                }
            }
        )
    }
    
    func animateImage(duration: Double, source: UIImageView, destination: UIImageView, completion: (()->Void)? = nil) {
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
    
    // MARK: private helpers
    
    private func transformFromRectToRect(#from: CGRect, to: CGRect) -> CGAffineTransform {
        
        var xScale = from.width / to.width
        var yScale = from.height / to.height
        var scale = CGAffineTransformMakeScale(xScale, yScale)
        
        var xTranslation = from.midX - to.midX
        var yTranslation = from.midY - to.midY
        var translate = CGAffineTransformMakeTranslation(xTranslation, yTranslation)
    
        return CGAffineTransformConcat(scale, translate)
    }
}