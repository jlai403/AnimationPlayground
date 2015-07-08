import UIKit

class CustomTransitionSourceController: UIViewController {
    
    let transitionManager = TransitionManager(type: TransitionType.CustomTransition)
    
    @IBOutlet weak var circle: CircleView!
    @IBOutlet weak var image: RoundUIImageView!
    

    @IBAction func onSwipe(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("customTransitionSourceToDestination", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customTransitionSourceToDestination" {
            let destinationController = segue.destinationViewController as! UIViewController
            destinationController.transitioningDelegate = transitionManager
        }
    }
    
    @IBAction func unwindToCustomTransitionSource(segue: UIStoryboardSegue) {
        
    }
}