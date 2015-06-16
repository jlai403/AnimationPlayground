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