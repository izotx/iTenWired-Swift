import UIKit

class AutoresizeTextView: UITextView {
  
  var heightConstraint: NSLayoutConstraint?
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.setNeedsUpdateConstraints()
  }
  
  override func updateConstraints() {
    let size = self.sizeThatFits(CGSizeMake(self.bounds.width, CGFloat(FLT_MAX)))
    
    if self.heightConstraint == nil {
      self.heightConstraint = NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: CGFloat(1), constant: size.height)
      
      self.addConstraint(self.heightConstraint!)
    }
    
    self.heightConstraint!.constant = size.height
    super.updateConstraints()
  }
  
}