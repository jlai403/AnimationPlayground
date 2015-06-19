import UIKit

class CustomTransitionDestinationController: UIViewController {
    
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

}