//
//  ImageRonde.swift
//  Les Calanques
//
//  Created by Adib Lgs on 2019-09-15.
//  Copyright © 2019 Adib Lgs. All rights reserved.
//

import UIKit

class ImageRonde: UIImageView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
   
    }
    
    func setup() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
}
