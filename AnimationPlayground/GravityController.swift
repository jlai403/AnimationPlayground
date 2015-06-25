import UIKit

class GravityController: UIViewController {
    
    @IBOutlet weak var ball: CircleView!
    
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    
    override func viewDidLoad() {
        enableDynamicAnimation()
    }
    
    private func enableDynamicAnimation() {
        setUpEnvironment()
        configureItems()
    }
    
    private func disableDynamicAnimation() {
        self.animator?.removeAllBehaviors()
    }
    
    private func setUpEnvironment() {
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        gravity?.addItem(ball)
        animator?.addBehavior(gravity)
        
        collision = UICollisionBehavior()
        collision?.translatesReferenceBoundsIntoBoundary = true
        collision?.addItem(ball)
        animator?.addBehavior(collision)
    }
    
    private func configureItems() {
        configureBall()
    }
    
    private func configureBall() {
        var ballBehaviour = UIDynamicItemBehavior(items: [ball])
        ballBehaviour.elasticity = 0.7
        ballBehaviour.density = 1.0
        animator?.addBehavior(ballBehaviour)
    }
  
    @IBAction func dragBall(sender: UIPanGestureRecognizer) {
        
        if (sender.state == UIGestureRecognizerState.Began) {
            disableDynamicAnimation()
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            var location = sender.locationInView(self.view)
            ball.center = location
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            enableDynamicAnimation()
        }
    }
}