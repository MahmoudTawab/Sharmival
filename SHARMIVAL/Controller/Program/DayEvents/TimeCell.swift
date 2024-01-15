//
//  TimeCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit

class TimeCell: UIView {
    
    var Time = String()
    lazy var View : StackLine = {
        let View = StackLine()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var Label : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0.1471783519, blue: 0.4268271923, alpha: 1)
        Label.backgroundColor = .clear
        Label.textAlignment = .center
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Medium", size: ControlWidth(16))
        return Label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.944993794, green: 0.9490355849, blue: 0.9490657449, alpha: 1)
        addSubview(Label)
        addSubview(View)
        View.topAnchor.constraint(equalTo: topAnchor).isActive = true
        View.heightAnchor.constraint(equalToConstant: ControlWidth(18)).isActive = true
        View.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(1)).isActive = true
        View.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-1)).isActive = true
        
        Label.topAnchor.constraint(equalTo: View.bottomAnchor,constant: ControlX(5)).isActive = true
        Label.bottomAnchor.constraint(equalTo: bottomAnchor,constant: ControlX(-5)).isActive = true
        Label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(2)).isActive = true
        Label.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(2)).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class StackLine: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for I in 0...30 {
            let View = UIView()
            View.backgroundColor = #colorLiteral(red: 0.8787193894, green: 0.3700291514, blue: 0.6252784729, alpha: 1)
            View.translatesAutoresizingMaskIntoConstraints = false
            
            
            if I == 15 {
            View.heightAnchor.constraint(equalToConstant: ControlWidth(27)).isActive = true
            }else{
            View.heightAnchor.constraint(equalToConstant: ControlWidth(9)).isActive = true
            }
            
            self.axis = .horizontal
            self.alignment = .top
            self.spacing = ControlX(2)
            self.backgroundColor = .clear
            self.distribution = .fillEqually
            self.addArrangedSubview(View)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
