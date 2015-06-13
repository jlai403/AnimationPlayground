import UIKit

class TranslationController: UIViewController {

    @IBOutlet weak var destination: UIView!
    
    @IBOutlet weak var origin: UIButton!
    
    @IBAction func translate(sender: UIButton) {
        var translatedLabel = toLabel(origin)
        self.view.addSubview(translatedLabel)
        
        UIButton.animateWithDuration(1.5,
            animations: {
                translatedLabel.frame = self.destination.frame
            },
            completion: { (finished) in
                var updatedButton: UIButton
                if let currentButton  = self.origin as? MoveButton {
                    updatedButton = self.getTryItAgainButton()
                } else {
                    updatedButton = self.getMoveButton()
                }
                
                updatedButton.addTarget(self, action: Selector("translate:"), forControlEvents: .TouchUpInside)

                self.origin.removeFromSuperview()
                self.origin = updatedButton
                self.view.addSubview(self.origin)
            }
        )
    }
    
    private func getTryItAgainButton() -> UIButton {
        var tryItAgainButton = TryItAgainButton.buttonWithType(UIButtonType.Custom) as! TryItAgainButton
        tryItAgainButton.update(self.origin.frame)
        return tryItAgainButton
    }
    
    private func getMoveButton() -> UIButton {
        var moveButton = MoveButton.buttonWithType(UIButtonType.Custom) as! MoveButton
        moveButton.update(self.origin.frame)
        return moveButton
    }
    
    func toLabel(origin: UIButton) -> UILabel {
        var label = UILabel(frame: origin.frame)
        label.backgroundColor = origin.backgroundColor
        label.text = origin.titleLabel?.text
        label.textColor = origin.titleLabel?.textColor
        label.textAlignment = NSTextAlignment.Center
        return label
    }
}

class MoveButton: UIButton {
    
    func update(frame: CGRect){
        setDefaults(frame)
    }
    
    private func setDefaults(frame: CGRect) {
        self.frame = frame
        self.backgroundColor = UIColor(red: 0.4, green: 0.8, blue: 1, alpha: 1)
        
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
        self.setTitle("move", forState: .Normal)
    }
}

class TryItAgainButton: UIButton {
    
    func update(frame: CGRect){
        setDefaults(frame)
    }
    
    private func setDefaults(frame: CGRect) {
        self.frame = frame
        self.backgroundColor = UIColor(red: 0.1803, green: 0.8, blue: 0.4431, alpha: 1)
        
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
        self.setTitle("that was easy...try it again", forState: .Normal)
    }
}