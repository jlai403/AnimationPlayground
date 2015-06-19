import UIKit

class TranslationController: UIViewController {
    
    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet var button: TranslateButton!
    
    @IBAction func translate(sender: UIButton) {
        sender.enabled = false
        
        button.copyToLabel(destinationLabel)
       
        AnimationHelper().animateElement(1.0, source: button, destination: self.destinationLabel) {
            self.button.removeFromSuperview()
            self.button = self.getNewButton()
            self.view.addSubview(self.button)
        }
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
}

class TranslateButton: UIButton {
    
    func copyToLabel(label: UILabel) -> UILabel {
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