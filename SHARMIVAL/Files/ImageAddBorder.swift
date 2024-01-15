//
//  ImageAddBorder.swift
//  SHARMIVAL
//
//  Created by Emojiios on 13/09/2022.
//

import UIKit

class ImageAddBorder: UIImageView {

    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    func AddBorder(Color:UIColor,width:CGFloat = 1) {
    let Radius = width * 2
    self.addSubview(Image)
    Image.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(Radius)).isActive = true
    Image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-Radius)).isActive = true
    Image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(Radius)).isActive = true
    Image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-Radius)).isActive = true
    self.backgroundColor = .clear
    self.layer.borderColor = Color.cgColor
    self.layer.borderWidth = ControlX(width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Image.layer.cornerRadius = Image.frame.height / 2
        Image.clipsToBounds = true
    }
}
