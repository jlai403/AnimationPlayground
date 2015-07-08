import UIKit

class CustomRotateTransitionSourceController: UIViewController {
    
    var transitionManager = TransitionManager(type: TransitionType.CustomRotateTransition)
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("customRotateTransitionSourceToDestination", sender: self)
    }
    
    @IBAction func unwindToCustomTransitionRotateSource(segue: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "customRotateTransitionSourceToDestination") {
            var destinationController = segue.destinationViewController as! UIViewController
            destinationController.transitioningDelegate = transitionManager
        }
    }
}