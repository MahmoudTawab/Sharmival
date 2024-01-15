//
//  ProgramCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 15/09/2022.
//

import UIKit

class ProgramCell: UICollectionViewCell {

    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var FName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "CocoGothic-Light" ,size: ControlWidth(60))
        return Label
    }()
    
    lazy var LName : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Bold" ,size: ControlWidth(140))
        return Label
    }()
    
    lazy var View : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(2.5)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FName,LName])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(30)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        clipsToBounds = true
        layer.cornerRadius = ControlX(20)
        
        addSubview(ImageView)
        ImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        ImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        addSubview(View)
        View.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        View.widthAnchor.constraint(equalToConstant: ControlWidth(5)).isActive = true
        View.heightAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        View.rightAnchor.constraint(equalTo: self.rightAnchor, constant: ControlX(-15)).isActive = true
        
        addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: ControlX(80)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: ControlX(-40)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(20)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
    }


}
