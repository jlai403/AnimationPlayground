import UIKit

@IBDesignable class RoundUIImageView: UIImageView {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initRoundUIImageView()
    }
    
    override init(image: UIImage!) {
        super.init(image: image)
        initRoundUIImageView()
    }
    
    override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        initRoundUIImageView()
    }

    private func initRoundUIImageView() {
        self.layer.masksToBounds = true

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initRoundUIImageView()
    }
}