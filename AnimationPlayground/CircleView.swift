import UIKit

@IBDesignable class CircleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.hidden = true
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)

        Colors.jordyBlue.set()
        
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