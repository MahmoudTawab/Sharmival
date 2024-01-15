//
//  CustomMarkerInfoWindow.swift
//  CustomMarker
//
//  Created by Sai Sandeep on 11/12/19.
//  Copyright © 2019 Sai Sandeep. All rights reserved.
//


import UIKit

class CustomMarkerInfoWindow: UIView {
    
    var txtLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var subtitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var chevronButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var imgView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(10)).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        
//        self.addSubview(chevronButton)
//        chevronButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        chevronButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ControlX(-8)).isActive = true
//        chevronButton.widthAnchor.constraint(equalToConstant: ControlWidth(16)).isActive = true
//        chevronButton.heightAnchor.constraint(equalToConstant: ControlWidth(16)).isActive = true
//        chevronButton.transform = CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
//        chevronButton.setImage(UIImage(named: "Path"), for: .normal)
//        chevronButton.isUserInteractionEnabled = false
//        chevronButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.addSubview(txtLabel)
        txtLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: ControlX(4)).isActive = true
        txtLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: ControlX(8)).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-8)).isActive = true
        txtLabel.bottomAnchor.constraint(greaterThanOrEqualTo: centerYAnchor, constant: ControlX(2)).isActive = true
        txtLabel.font = UIFont.systemFont(ofSize: ControlWidth(15), weight: .medium)
        txtLabel.numberOfLines = 2
        txtLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: txtLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subtitleLabel.font = UIFont.systemFont(ofSize: ControlWidth(13), weight: .light)
        subtitleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 2
        layer.masksToBounds = true
        layer.cornerRadius = ControlX(8)
    }
    
}
