//
//  CurrencyCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit

class CurrencyCell: UITableViewCell {

    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(15))
        return Label
    }()
        
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var ColorView:UIView = {
        let View = UIView()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        
        addSubview(BackgroundView)
        addSubview(ColorView)
        addSubview(LabelTitle)

        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        ColorView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)).isActive = true
        ColorView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor,constant: ControlX(-15)).isActive = true
        ColorView.topAnchor.constraint(equalTo: BackgroundView.topAnchor,constant: ControlX(15)).isActive = true
        ColorView.widthAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
            
        LabelTitle.topAnchor.constraint(equalTo: topAnchor,constant: ControlX(15)).isActive = true
        LabelTitle.bottomAnchor.constraint(equalTo: bottomAnchor,constant: ControlX(-15)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: ColorView.leadingAnchor,constant: ControlX(20)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor , constant: ControlX(-20)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
