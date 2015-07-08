
class TransitionTypeFactory {
    
    class func typeFor(type: TransitionType) -> ITransitionType {
        switch (type) {
        case .CustomTransition:
            return CustomTranstion()
        case .CustomRotateTransition:
            return RotateTransition()
        default:
            fatalError("unknown transition type: \(type)")
        }
    }
}