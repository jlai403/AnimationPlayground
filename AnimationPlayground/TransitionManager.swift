import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomSegueTransitionSourceController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomSegueTransitionDestinationController
        

        var animationCircle = CircleView(frame: sourceController.circle.frame)
        destinationController.view.addSubview(animationCircle)

        
        destinationController.view.layoutIfNeeded()
        containerView.addSubview(destinationController.view)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration,
            animations: {
                animationCircle.hidden = false
                animationCircle.frame = destinationController.circle.frame
                destinationController.view.backgroundColor = Colors.emeraldGreen
            },
            completion: { finished in
                transitionContext.completeTransition(true)
                destinationController.circle.hidden = false
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
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
