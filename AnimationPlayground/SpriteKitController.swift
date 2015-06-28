import UIKit
import SpriteKit

class SpriteKitController: UIViewController {
    
    private let HIDE_STATUS_BAR = true
    private let DEBUG = true
    
    var scene: SKScene!
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSkView()
        setUpScene()
    }
    
    private func setUpSkView() {
        if (DEBUG) {
            self.skView.showsFPS = true
            self.skView.showsNodeCount = true
        }
    }
    
    private func setUpScene() {
        self.scene = MyScene(size: view.bounds.size)
        self.scene.scaleMode = SKSceneScaleMode.AspectFill
        skView.presentScene(scene)
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    override func viewDidDisappear(animated: Bool) {
        self.scene.paused = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return HIDE_STATUS_BAR;
    }
}

class MyScene: SKScene {
    
    var SQUARE_SPRITE_NAME = "square"
    
    var sprites = [SKSpriteNode]()
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = view.backgroundColor!
        setUpBoundaries()
        var square = renderSquare(width: 50.0, height: 50.0)
        animateSquare(square, position: view.center, duration: 2.0)
    }
    
    private func setUpBoundaries() {
        var boundary = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = boundary
    }
    
    private func renderSquare(#width: CGFloat, height: CGFloat) -> SKSpriteNode {
        
        var square = SKSpriteNode(color: Colors.emeraldGreen, size: CGSizeMake(width, height))
        square.position = CGPointMake(0, 0)
        square.name = SQUARE_SPRITE_NAME
        
        square.physicsBody = SKPhysicsBody(rectangleOfSize: square.size)
        if let squarePhysics = square.physicsBody {
            squarePhysics.affectedByGravity = true
            squarePhysics.allowsRotation = false
            squarePhysics.dynamic = true
            squarePhysics.friction = 0.0
            squarePhysics.restitution = 0.5
        }
        
        addChild(square)
        sprites.append(square)
        
        return square
    }
    
    private func animateSquare(square: SKSpriteNode, position: CGPoint, duration: NSTimeInterval) {
        let move = SKAction.moveTo(position, duration: duration)
        var steps:[SKAction] = [move]
        
        square.runAction(SKAction.sequence(steps))
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var square = childNodeWithName(SQUARE_SPRITE_NAME) as! SKSpriteNode
        square.physicsBody!.affectedByGravity = false
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        var previouslocation = touch.previousLocationInNode(self)
        var xDelta = (touchLocation.x - previouslocation.x)
        var yDelta = (touchLocation.y - previouslocation.y)

        var square = childNodeWithName(SQUARE_SPRITE_NAME) as! SKSpriteNode
        var newX = square.position.x + xDelta
        var newY = square.position.y + yDelta
        
        square.position = CGPointMake(newX, newY)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        var square = childNodeWithName(SQUARE_SPRITE_NAME) as! SKSpriteNode
        square.physicsBody!.affectedByGravity = true
    }
}