//
//  LineCell.swift
//  SampleGraph
//
//  Created by 高橋翼 on 2020/09/10.
//  Copyright © 2020 高橋翼. All rights reserved.
//

import UIKit

class LineCell: UICollectionViewCell {

    @IBOutlet weak var strokeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(ratio: CGFloat) {
        strokeView.transform = .identity
        strokeView.transform = strokeView.transform.scaledBy(x: 1, y: CGFloat(ratio))
    }

}
