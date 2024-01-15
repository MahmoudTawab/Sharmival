//
//  GallerCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit

class GallerCell : UICollectionViewCell {

    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .black
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.cornerRadius = ControlX(8)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

}

