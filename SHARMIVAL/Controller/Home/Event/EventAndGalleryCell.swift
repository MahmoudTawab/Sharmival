//
//  EventAndGalleryCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 12/09/2022.
//

import UIKit

class EventAndGalleryCell: UICollectionViewCell {
    
    lazy var Image : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .black
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.cornerRadius = ControlX(8)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var DateLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Light", size: ControlWidth(14))
        return Label
    }()
    
    lazy var EventName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "CocoGothic-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,EventName])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(Image)
        Image.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        Image.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        Image.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        Image.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        addSubview(StackLabel)
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        StackLabel.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(20)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-30)).isActive = true
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
