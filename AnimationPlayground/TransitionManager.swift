import UIKit

class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    private var presenting = false
    private var transition: ITransitionType?
    
    init(type: TransitionType) {
        super.init()
        initTransitionType(type)
    }
    
    private func initTransitionType(type: TransitionType) {
        self.transition = TransitionTypeFactory.typeFor(type)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        containerView.addSubview(destinationController.view)
        destinationController.view.layoutIfNeeded()
        
        let transition = self.transition!
        transition.setup(self.presenting, sourceController, destinationController)
        transition.run()
        
        transitionContext.completeTransition(true)
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return transition!.duration
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
