import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
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
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomSegueTransitionSourceController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomSegueTransitionDestinationController
        
        sourceController.circle.hidden = true
        
        var animationCircle = CircleView(frame: sourceController.circle.frame)
        destinationController.view.addSubview(animationCircle)
        destinationController.view.layoutIfNeeded()
        
        containerView.addSubview(destinationController.view)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                animationCircle.hidden = false
                animationCircle.frame = destinationController.circle.frame
                destinationController.view.backgroundColor = Colors.emeraldGreen
            },
            completion: { finished in
                transitionContext.completeTransition(true)
                animationCircle.removeFromSuperview()
            }
        )
    }
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomSegueTransitionDestinationController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomSegueTransitionSourceController
        
        sourceController.circle.hidden = true
        
        var animationCircle = CircleView(frame: sourceController.circle.frame)
        destinationController.view.addSubview(animationCircle)
        destinationController.view.layoutIfNeeded()
        
        containerView.addSubview(destinationController.view)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
            animations: {
                animationCircle.hidden = false
                animationCircle.frame = destinationController.circle.frame
                destinationController.view.backgroundColor = UIColor.whiteColor()
            },
            completion: { finished in
                transitionContext.completeTransition(true)
                animationCircle.removeFromSuperview()
            }
        )
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 1.0
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
