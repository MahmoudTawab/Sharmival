//
//  LocalizableCircleCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit

class LocalizableCircleCell: UICollectionViewCell {
    
    let ImageView = UIImageView()
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        ImageView.frame = rect
        addSubview(ImageView)
    }
}
