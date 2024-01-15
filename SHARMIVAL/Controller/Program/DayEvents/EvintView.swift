//
//  EvintView.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit

protocol EvintViewDelegate {
    func EvintViewActionFav(_ Evint:EvintView)
}

class EvintView: UIView {
    
    var IsFav = Bool()
    var ScheduleId : String?
    var Delegate : EvintViewDelegate?
    lazy var EvintImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .black
        ImageView.contentMode = .scaleAspectFill
        ImageView.layer.cornerRadius = ControlX(8)
        ImageView.image = UIImage(named: "Group 26056")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var DateLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Light", size: ControlWidth(17))
        Label.font = UIFont.systemFont(ofSize: ControlWidth(12), weight: .light)
        return Label
    }()
    
    lazy var FNameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Medium", size: ControlWidth(23))
        return Label
    }()
    
    lazy var LNameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.font = UIFont.systemFont(ofSize: ControlWidth(24), weight: .medium)
        return Label
    }()
    
    
    lazy var StackLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateLabel,FNameLabel,LNameLabel])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(5)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var FavButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = .clear
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionFav), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionFav() {
    Delegate?.EvintViewActionFav(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(EvintImage)
        EvintImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        EvintImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        EvintImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(2)).isActive = true
        EvintImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-2)).isActive = true
        
        self.addSubview(StackLabel)
        StackLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlX(30)).isActive = true
        StackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-30)).isActive = true
        StackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-50)).isActive = true
        
        
        self.addSubview(FavButton)
        FavButton.widthAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        FavButton.heightAnchor.constraint(equalTo: FavButton.widthAnchor).isActive = true
        FavButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlX(-20)).isActive = true
        FavButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

