import UIKit

class TranslationController: UIViewController {

    private let TRANSLATE_INTERVAL = 1.0
    
    @IBOutlet weak var destination: UIView!
    
    @IBOutlet weak var button: TranslateButton!
    
    var translatedLabel: UILabel?
    
    @IBAction func translate(sender: UIButton) {
        sender.enabled = false
        
        var newLabel = button.toLabel()
        self.view.addSubview(newLabel)
        
        UIButton.animateWithDuration(TRANSLATE_INTERVAL,
            animations: {
                newLabel.frame = self.destination.frame
            },
            completion: { (finished) in
                var newButton = self.getNewButton()
                self.cleanup(newButton, newLabel: newLabel)
            }
        )
    }
    
    private func getNewButton() -> TranslateButton {
        var newButton: TranslateButton
       
        if let currentButton  = self.button as? MoveButton {
            newButton = TryItAgainButton.buttonWithType(UIButtonType.Custom) as! TranslateButton
        } else {
            newButton = MoveButton.buttonWithType(UIButtonType.Custom) as! TranslateButton
        }
        
        newButton.update(self.button.frame)
        newButton.addTarget(self, action: Selector("translate:"), forControlEvents: .TouchUpInside)

        return newButton
    }
    
    func cleanup(newButton:TranslateButton, newLabel:UILabel) {
        self.button.removeFromSuperview()
        self.button = newButton
        self.view.addSubview(self.button)
        
        if let label = translatedLabel as UILabel! {
            label.removeFromSuperview()
            
        }
        self.translatedLabel = newLabel
    }
}

class TranslateButton: UIButton {
    
    func toLabel() -> UILabel {
        var label = UILabel(frame: self.frame)
        label.backgroundColor = self.backgroundColor
        label.text = self.titleLabel?.text
        label.textColor = self.titleLabel?.textColor
        label.textAlignment = NSTextAlignment.Center
        return label
    }
    
    func update(frame: CGRect) {
        fatalError("not implemented")
    }
}

class MoveButton: TranslateButton {
    
    override func update(frame: CGRect){
        self.frame = frame
        self.backgroundColor = Colors.lightBlue
        
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
        self.setTitle("move", forState: .Normal)
    }
}

class TryItAgainButton: TranslateButton {
    
    override func update(frame: CGRect){
        self.frame = frame
        self.backgroundColor = Colors.emeraldGreen
        
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.titleLabel?.textAlignment = .Center
        self.setTitle("that was easy...", forState: .Normal)
    }
}