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
    
    var sprites = [SKSpriteNode]()
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = view.backgroundColor!
        
        var square = renderSquare(width: 50.0, height: 50.0)
        moveSquare(square, position: view.center, duration: 2.0)
    }
    
    func renderSquare(#width: CGFloat, height: CGFloat) -> SKSpriteNode {
        
        var square = SKSpriteNode(color: Colors.emeraldGreen, size: CGSizeMake(width, height))
        square.position = CGPointMake(0, 0)
        addChild(square)
        sprites.append(square)
        
        return square
    }
    
    func moveSquare(square: SKSpriteNode, position: CGPoint, duration: NSTimeInterval) {
        let move = SKAction.moveTo(position, duration: duration)
        var steps:[SKAction] = [move]
        
        square.runAction(SKAction.sequence(steps))
    }
}