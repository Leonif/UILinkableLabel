//
//  UILinkedLabel.swift
//  Tele2
//
//  Created by l.nifantyev on 10/10/18.
//  Copyright © 2018 Tele2. All rights reserved.
//

import Foundation
import UIKit

class UILinkedLabel: UIView, UITextViewDelegate {
  
  var onClick: ((URL) -> Void)? = nil
  var attributedText: NSAttributedString?
  private var textView: UITextView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
      configure()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.addSubview(textView)
    textView.fillSuperview()
  }
  override var intrinsicContentSize: CGSize {
    return CGSize(width: self.frame.width, height: textView.contentSize.height)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    configure()
  }
  
  func setupLink(_ linkableText: String, with color: UIColor, link: String) {
    guard let attributedText = attributedText else {
      fatalError("attributedText is not set !!!")
    }
    
    let wholeText = attributedText.string
    
    guard let location = wholeText.range(of: linkableText) else {
      fatalError("linkableText is not found as substring")
    }
    
    let linkTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
    
    textView.linkTextAttributes = linkTextAttributes
    
    let distance = wholeText.distance(from: wholeText.startIndex, to: location.lowerBound)
    
    let mutable =  NSMutableAttributedString()
      
    mutable.append(attributedText)
    
    mutable.addAttribute(.link,
                         value: link,
                         range: NSRange(location: distance,
                                        length: linkableText.count))

    self.attributedText = mutable
    self.textView.attributedText = self.attributedText
    
    invalidateIntrinsicContentSize()
  }
  
  private func configure() {
    textView = UITextView(frame: CGRect.zero)
    textView.delegate = self
    textView.textContainerInset = UIEdgeInsets.zero
    textView.textContainer.lineFragmentPadding = 0
    textView.isScrollEnabled = false
    textView.isEditable = false
  }
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

    onClick?(URL)
    
    return false
  }
}

extension UIView {
  func fillSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
      rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
      topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
      bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
  }
}
