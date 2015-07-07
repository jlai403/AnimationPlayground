import UIKit

class CustomRotateTransitionSourceController: UIViewController {
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        self.performSegueWithIdentifier("customRotateTransitionSourceToDestination", sender: self)
    }
    
    @IBAction func unwindToCustomTransitionRotateSource(segue: UIStoryboardSegue) {
        
    }
}