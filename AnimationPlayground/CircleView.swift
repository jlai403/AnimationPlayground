import UIKit

@IBDesignable class CircleView: UIView {
    
    private var selectedColor: UIColor?
    private var selectedLineWidth: CGFloat = 1.0
    
    @IBInspectable var lineColor: UIColor = UIColor.blackColor() {
        didSet {
            selectedColor = lineColor
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 1.0 {
        didSet {
            selectedLineWidth = lineWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaults()
    }
    
    init(copy: CircleView) {
        super.init(frame: copy.frame)
        setDefaults()
        self.selectedColor = copy.lineColor
        self.selectedLineWidth = copy.lineWidth
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setDefaults()
    }
    
    private func setDefaults() {
        self.backgroundColor = UIColor.clearColor()
        self.hidden = true
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, selectedLineWidth)

        selectedColor?.set()
        
        CGContextAddArc(context, (frame.size.width)/2, (frame.size.height)/2, (frame.size.width - 10)/2, 0, CGFloat(M_PI*2.0), 1)
        
        CGContextStrokePath(context)
    }
    
    func reset(x: CGFloat, y: CGFloat) {
        var endSize = CGFloat(100)
        var halfEndSize = endSize / 2
        self.frame = CGRectMake(x - halfEndSize, y - halfEndSize, endSize, endSize)
        self.alpha = 1.0
        self.hidden = true
    }
}