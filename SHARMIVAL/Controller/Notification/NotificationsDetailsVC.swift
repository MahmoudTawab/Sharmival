//
//  NotificationsDetailsVC.swift
//  SHARMIVAL (iOS)
//
//  Created by Emoji Technology on 08/08/2021.
//

import UIKit

class NotificationsDetailsVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.ShowNotifications = false
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(ViewDismiss)
        ViewDismiss.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(5)).isActive = true
        ViewDismiss.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        ViewDismiss.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        ViewDismiss.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        view.addSubview(LabelDate)
        LabelDate.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(5)).isActive = true
        LabelDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        LabelDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        LabelDate.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        view.addSubview(Message)
        Message.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: ControlX(-15)).isActive = true
        Message.topAnchor.constraint(equalTo: LabelDate.bottomAnchor, constant: ControlY(5)).isActive = true
        Message.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        Message.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
    }
    
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(35), height: ControlWidth(35))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var LabelDate : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Gotham-Bold" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var Message : UITextView = {
        let TV = UITextView()
        TV.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        TV.isEditable = false
        TV.backgroundColor = .clear
        TV.keyboardAppearance = .light
        TV.translatesAutoresizingMaskIntoConstraints = false
        TV.font = UIFont(name: "Poppins-Regular" ,size: ControlWidth(16))
        TV.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 4)
        return TV
    }()
    
    
}
