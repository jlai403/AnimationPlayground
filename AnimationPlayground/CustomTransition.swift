import UIKit

class CustomTranstion: ITransitionType {
    
    private var presenting = Bool()
    weak private var _sourceController: UIViewController?
    weak private var _destinationController: UIViewController?
    
    private var customTransitionSourceController: CustomTransitionSourceController {
        get {
            return presenting
                ? (_sourceController as? CustomTransitionSourceController)!
                : (_destinationController as? CustomTransitionSourceController)!
        }
    }
    
    private var customTransitionDestinationController: CustomTransitionDestinationController {
        get {
            return presenting
                ? (_destinationController as? CustomTransitionDestinationController)!
                : (_sourceController as? CustomTransitionDestinationController)!
        }
    }
    
    var duration: Double {
        get {
            return 1.5
        }
    }
    
    func setup(presenting: Bool, _ sourceController: UIViewController, _ destinationController: UIViewController) {
        self.presenting = presenting
        self._sourceController = sourceController
        self._destinationController = destinationController
    }
    
    func run() {
        if presenting {
            runPresentingAnimation()
        } else{
            runDismissAnimation()
        }
    }
    
    private func runPresentingAnimation() {
        AnimationHelper().animateElement(duration, source: customTransitionSourceController.circle, destination: customTransitionDestinationController.circle)
        
        AnimationHelper().animateImage(duration, source: customTransitionSourceController.image, destination: customTransitionDestinationController.image)
    }
    
    private func runDismissAnimation() {
        AnimationHelper().animateElement(duration, source: customTransitionDestinationController.circle, destination: customTransitionSourceController.circle)
        
        AnimationHelper().animateImage(duration, source: customTransitionDestinationController.image, destination: customTransitionSourceController.image)
    }
}