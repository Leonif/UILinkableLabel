//
//  ViewController.swift
//  UILinkedLabelExample
//
//  Created by l.nifantyev on 10/10/18.
//  Copyright © 2018 l.nifantyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet private weak var linkableLabel: UILinkedLabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let attributtedString = NSMutableAttributedString(string: "Test link label")
    
    linkableLabel.attributedText = attributtedString
    linkableLabel.setupLink("link", with: .red, link: "https://www.apple.com")
    linkableLabel.onClick = { url in
      UIApplication.shared.open(url, options: [:])
    }
    
  }
}

