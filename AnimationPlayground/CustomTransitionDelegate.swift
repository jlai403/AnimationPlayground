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
        
        var circleStartAnimationFrame = sourceController.circle.frame
        var circleDestinationAnimationFrame = destinationController.circle.frame
        destinationController.circle.frame = circleStartAnimationFrame
        
        var imageStartAnimationFrame = sourceController.image.frame
        var imageDestinationAnimationFrame = destinationController.image.frame
        destinationController.image.frame = imageStartAnimationFrame
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                destinationController.circle.frame = circleDestinationAnimationFrame
                destinationController.image.frame = imageDestinationAnimationFrame
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
        
        var circleStartAnimationFrame = sourceController.circle.frame
        var circleDestinationAnimationFrame = destinationController.circle.frame
        destinationController.circle.frame = circleStartAnimationFrame
        
        var imageStartAnimationFrame = sourceController.image.frame
        var imageDestinationAnimationFrame = destinationController.image.frame
        destinationController.image.frame = imageStartAnimationFrame
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                destinationController.circle.frame = circleDestinationAnimationFrame
                destinationController.image.frame = imageDestinationAnimationFrame
                destinationController.view.backgroundColor = Colors.capeHoney
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

    // return the animataor when presenting a viewcontroller
    // remmeber that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}
