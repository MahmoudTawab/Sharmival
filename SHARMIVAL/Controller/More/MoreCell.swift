//
//  MoreCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit

class MoreCell: UICollectionViewCell {
    
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 2
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.contentMode = "lang".localizable == "ar" ? .bottomLeft : .bottomRight
        return ImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(LabelTitle)
        addSubview(ImageView)
        
        LabelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        LabelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(15)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/1.6).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
