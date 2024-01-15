//
//  NotificationsCell.swift
//  SHARMIVAL (iOS)
//
//  Created by Emoji Technology on 07/08/2021.
//

import UIKit
protocol NotificationsDelegate {
    func ActionView(cell:NotificationsCell)
}

class NotificationsCell: SwipeTableViewCell {

    var Delegate : NotificationsDelegate?
    lazy var LabelTitle : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(15))
        return Label
    }()
        
    lazy var BackgroundView : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionBackground)))
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    @objc func ActionBackground() {
    Delegate?.ActionView(cell: self)
    }
   
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(14))
        return Label
    }()
    
    lazy var ViewLine : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
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
        backgroundColor = .clear
        contentView.isHidden = true
        addSubview(BackgroundView)
        addSubview(ColorView)
        addSubview(LabelTitle)
        addSubview(LabelDate)
        addSubview(ViewLine)

        BackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        BackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        BackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        BackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        ColorView.leadingAnchor.constraint(equalTo: BackgroundView.leadingAnchor,constant: ControlX(15)).isActive = true
        ColorView.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor,constant: ControlX(-15)).isActive = true
        ColorView.topAnchor.constraint(equalTo: BackgroundView.topAnchor,constant: ControlX(15)).isActive = true
        ColorView.widthAnchor.constraint(equalToConstant: ControlWidth(3)).isActive = true
        
        ViewLine.topAnchor.constraint(equalTo: BackgroundView.topAnchor).isActive = true
        ViewLine.heightAnchor.constraint(equalToConstant: ControlWidth(0.4)).isActive = true
        ViewLine.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(15)).isActive = true
        ViewLine.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-15)).isActive = true
            
        LabelTitle.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        LabelTitle.topAnchor.constraint(equalTo: BackgroundView.topAnchor,constant: ControlX(10)).isActive = true
        LabelTitle.leadingAnchor.constraint(equalTo: ColorView.leadingAnchor,constant: ControlX(20)).isActive = true
        LabelTitle.trailingAnchor.constraint(equalTo: BackgroundView.trailingAnchor , constant: ControlX(-20)).isActive = true
        
        LabelDate.widthAnchor.constraint(equalTo: LabelTitle.widthAnchor).isActive = true
        LabelDate.leadingAnchor.constraint(equalTo: LabelTitle.leadingAnchor).isActive = true
        LabelDate.topAnchor.constraint(equalTo: LabelTitle.bottomAnchor,constant: ControlX(10)).isActive = true
        LabelDate.bottomAnchor.constraint(equalTo: BackgroundView.bottomAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
