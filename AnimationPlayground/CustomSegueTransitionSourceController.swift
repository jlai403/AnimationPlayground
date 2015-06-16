import UIKit

class CustomSegueTransitionSourceController: UIViewController {
    
    let transitionManager = TransitionManager()
    
    @IBOutlet weak var circle: CircleView!

    override func viewDidAppear(animated: Bool) {
        self.circle.hidden = false
    }
    
    @IBAction func transition(sender: UIButton) {
        self.performSegueWithIdentifier("customSegueSourceToCustomSegueDestination", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "customSegueSourceToCustomSegueDestination" {
            let destinationController = segue.destinationViewController as! UIViewController

            destinationController.transitioningDelegate = transitionManager
        }
    }
    
    @IBAction func unwindToCustomSegueTransitionSource(segue: UIStoryboardSegue) {
        
    }
}