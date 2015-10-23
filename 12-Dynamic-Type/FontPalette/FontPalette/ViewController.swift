//
//  ViewController.swift
//  FontPalette
//
//  Created by WJ on 15/10/23.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var subHeadLineLabel: UILabel!
    
    @IBOutlet weak var boldlabel: UILabel!

    @IBOutlet weak var scriptTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subHeadLineLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody)
        let boldBodyFontDescriptpr = bodyFontDescriptor.fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        boldlabel.font = UIFont(descriptor: boldBodyFontDescriptpr, size: 0)
        
        let scriptFontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute:"Zapfino",
                                                     UIFontDescriptorSizeAttribute:15])
        scriptTextLabel.font = UIFont(descriptor: scriptFontDescriptor, size: 0)
    }
}

