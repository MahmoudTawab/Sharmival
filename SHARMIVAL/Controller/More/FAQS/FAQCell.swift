//
//  FAQCell.swift
//  LLDC
//
//  Created by Emojiios on 02/04/2022.
//

import UIKit

class FAQCell : UITableViewCell {

    lazy var OpenClose : UIImageView = {
        let Image = UIImageView()
        Image.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Path")
        Image.contentMode = .scaleAspectFit
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
 
    lazy var TextTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(18))
        return Label
    }()

    lazy var TheDetails : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(16))
        return Label
    }()
    
    
    lazy var ViewBackground : UIView = {
        let View = UIView()
        View.clipsToBounds = true
        View.layer.cornerRadius = ControlX(10)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear

        addSubview(ViewBackground)
        ViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(10)).isActive = true
        ViewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(15)).isActive = true
        ViewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-15)).isActive = true
        ViewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-10)).isActive = true
        
        addSubview(OpenClose)
        OpenClose.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-30)).isActive = true
        OpenClose.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(25)).isActive = true
        OpenClose.widthAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        OpenClose.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true

        let StackVertical = UIStackView(arrangedSubviews: [TextTitle,TheDetails])
        StackVertical.axis = .vertical
        StackVertical.spacing = ControlX(20)
        StackVertical.backgroundColor = .clear
        StackVertical.distribution = .equalSpacing
        StackVertical.translatesAutoresizingMaskIntoConstraints = false

        ViewBackground.addSubview(StackVertical)
        StackVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlY(25)).isActive = true
        StackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: ControlX(30)).isActive = true
        StackVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-50)).isActive = true
        StackVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: ControlY(-30)).isActive = true
        contentView.isHidden = true
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }

}

