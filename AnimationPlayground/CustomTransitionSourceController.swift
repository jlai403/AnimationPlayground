import UIKit

class CustomTransitionSourceController: UIViewController {
    
    let customTransitionDelegate = TransitionManager(type: .CustomTransition)
    
    @IBOutlet weak var circle: CircleView!
    @IBOutlet weak var image: RoundUIImageView!
    

    @IBAction func onSwipe(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("customTransitionSourceToDestination", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customTransitionSourceToDestination" {
            let destinationController = segue.destinationViewController as! UIViewController

            destinationController.transitioningDelegate = customTransitionDelegate
        }
    }
    
    @IBAction func unwindToCustomTransitionSource(segue: UIStoryboardSegue) {
        
    }
}