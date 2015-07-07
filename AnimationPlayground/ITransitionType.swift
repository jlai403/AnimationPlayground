import UIKit

enum TransitionType {
    case CustomTransition
    case CustomRotateTransition
}

protocol ITransitionType {
    var duration: Double { get }
    
    func setup(presenting: Bool, _ sourceController: UIViewController, _ destinationController: UIViewController)
    func run()
}