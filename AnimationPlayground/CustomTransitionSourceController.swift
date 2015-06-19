import UIKit

class CustomTransitionSourceController: UIViewController {
    
    let customTransitionDelegate = CustomTransitionDelegate()
    
    @IBOutlet weak var circle: CircleView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        styleAvatar()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    func styleAvatar() {
        self.image.layer.cornerRadius = self.image.frame.width / 2
        self.image.layer.masksToBounds = true
        self.image.layer.borderColor = Colors.jordyBlue.CGColor
        self.image.layer.borderWidth = 3
    }
    
    @IBAction func onSwipe(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("customSegueSourceToCustomSegueDestination", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customSegueSourceToCustomSegueDestination" {
            let destinationController = segue.destinationViewController as! UIViewController

            destinationController.transitioningDelegate = customTransitionDelegate
        }
    }
    
    @IBAction func unwindToCustomTransitionSource(segue: UIStoryboardSegue) {
        
    }
}


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
        
        var duration = self.transitionDuration(transitionContext)
        
        AnimationHelper().animateElement(duration, source: sourceController.circle, destination: destinationController.circle)
        
        AnimationHelper().animateImageWithCircleBorder(duration, source: sourceController.image, destination: destinationController.image) {
            transitionContext.completeTransition(true)
        }
    }
    
    private func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let sourceController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! CustomTransitionDestinationController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! CustomTransitionSourceController
        
        containerView.addSubview(destinationController.view)
        destinationController.view.layoutIfNeeded()
        
        var duration = self.transitionDuration(transitionContext)
        
        AnimationHelper().animateElement(duration, source: sourceController.circle, destination: destinationController.circle)
        
        AnimationHelper().animateImageWithCircleBorder(duration, source: sourceController.image, destination: destinationController.image) {
            transitionContext.completeTransition(true)
        }
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
