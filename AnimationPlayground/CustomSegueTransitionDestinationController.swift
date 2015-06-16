import UIKit

class CustomSegueTransitionDestinationController: UIViewController {
    
    @IBOutlet weak var circle: CircleView!
    
    override func viewDidAppear(animated: Bool) {
        self.circle.hidden = false
    }
}