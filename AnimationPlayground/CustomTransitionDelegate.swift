import UIKit

class CustomTransitionDelegate: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = false
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            presentingAnimation(transitionContext)
        } else {
            dismissAnimation(transitionContext)
        }
    }
    
    private func presentingAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomTransitionSourceController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomTransitionDestinationController
        
        containerView.addSubview(destinationController.view)
        destinationController.view.layoutIfNeeded()
        
        var sourceCircleFrame = sourceController.circle.frame
        var destinationCircleFrame = destinationController.circle.frame
        destinationController.circle.frame = sourceCircleFrame
        
        var sourceImageFrame = sourceController.image.frame
        var destinationImageFrame = destinationController.image.frame
        destinationController.image.frame = sourceImageFrame
        
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = sourceController.image.layer.cornerRadius
        animation.toValue = destinationImageFrame.width / 2.0
        animation.duration = self.transitionDuration(transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        destinationController.image.layer.addAnimation(animation, forKey: "cornerRadius")
        

        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                destinationController.circle.frame = destinationCircleFrame

                destinationController.image.frame = destinationImageFrame
                destinationController.view.backgroundColor = Colors.capeHoney
            },
            completion: { finished in
                transitionContext.completeTransition(true)
            }
        )
    }
    
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomTransitionDestinationController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomTransitionSourceController
        
        containerView.addSubview(destinationController.view)
        destinationController.view.layoutIfNeeded()
        
        destinationController.view.backgroundColor = Colors.capeHoney
        
        var sourceCircleFrame = sourceController.circle.frame
        var destinationCircleFrame = destinationController.circle.frame
        destinationController.circle.frame = sourceCircleFrame
        
        var sourceImageFrame = sourceController.image.frame
        var destinationImageFrame = destinationController.image.frame
        destinationController.image.frame = sourceImageFrame
        
        let cornerRadiusAnimation = CABasicAnimation(keyPath: "cornerRadius")
        cornerRadiusAnimation.fromValue = sourceController.image.layer.cornerRadius
        cornerRadiusAnimation.toValue = destinationImageFrame.width / 2.0
        cornerRadiusAnimation.duration = self.transitionDuration(transitionContext)
        cornerRadiusAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        destinationController.image.layer.addAnimation(cornerRadiusAnimation, forKey: "cornerRadius")
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                destinationController.circle.frame = destinationCircleFrame

                destinationController.image.frame = destinationImageFrame
                destinationController.view.backgroundColor = UIColor.whiteColor()
            },
            completion: { finished in
                transitionContext.completeTransition(true)
            }
        )
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.5
    }

    
    // MARK: UIViewControllerTransitioningDelegate protocol methods

    // presenting - segue
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // dismissing - unwind
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
