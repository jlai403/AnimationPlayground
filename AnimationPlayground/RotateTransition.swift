import UIKit

class RotateTransition: ITransitionType {
    
    private var presenting = Bool()
    weak private var sourceController: UIViewController?
    weak private var destinationController: UIViewController?
    
    var duration: Double {
        get {
            return 1.0
        }
    }
    
    func setup(presenting: Bool, _ sourceController: UIViewController, _ destinationController: UIViewController) {
        self.presenting = presenting
        self.sourceController = sourceController
        self.destinationController = destinationController
    }
    
    func run() {
        if presenting {
            runPresentingTransition()
        } else {
            runDismissTransition()
        }
    }
    
    private func runPresentingTransition() {
        destinationController!.view.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI_2))
        destinationController!.view.layer.anchorPoint = CGPointMake(0.0, 0.0)
        destinationController!.view.layer.position = CGPointMake(0.0, 0.0)
        
        UIView.animateWithDuration(duration) {
            self.destinationController!.view.transform = CGAffineTransformIdentity
        }
    }
    
    private func runDismissTransition() {
        destinationController!.view.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        destinationController!.view.layer.anchorPoint = CGPointMake(0.0, 0.0)
        destinationController!.view.layer.position = CGPointMake(0.0, 0.0)
        
        UIView.animateWithDuration(duration) {
            self.destinationController!.view.transform = CGAffineTransformIdentity
        }
    }
}