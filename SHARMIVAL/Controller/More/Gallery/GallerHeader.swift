//
//  GallerHeader.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit

class GallerHeader: UICollectionReusableView {

    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(20))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(TitleLabel)
        TitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        TitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        TitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(10)).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-10)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

