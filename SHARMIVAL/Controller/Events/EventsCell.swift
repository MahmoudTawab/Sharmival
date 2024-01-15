//
//  EventsCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 15/09/2022.
//

import UIKit

class EventsCell: UICollectionViewCell {

    lazy var ImageView : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    lazy var LabelName : UILabel = {
        let Label = UILabel()
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    func SetTextName(_ FName:String,_ LName:String) {
        
        let attributedString = NSMutableAttributedString(string: FName, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(30)) ?? UIFont.systemFont(ofSize: ControlWidth(30)),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: LName, attributes: [
            .font: UIFont(name: "CocoGothic-Heavy", size: ControlWidth(35)) ?? UIFont.systemFont(ofSize: ControlWidth(35)),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]))
        
        LabelName.numberOfLines = 0
        LabelName.backgroundColor = .clear
        LabelName.attributedText = attributedString
    }
    
    lazy var View : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(2.5)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
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
        
        addSubview(LabelName)
        LabelName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        LabelName.heightAnchor.constraint(equalTo: self.heightAnchor, constant: ControlY(-100)).isActive = true
        LabelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ControlX(35)).isActive = true
        LabelName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: ControlX(-20)).isActive = true
    }


}
