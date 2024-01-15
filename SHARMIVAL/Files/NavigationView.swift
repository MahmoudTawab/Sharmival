//
//  NavigationView.swift
//  SHARMIVAL
//
//  Created by Emojiios on 11/09/2022.
//

import UIKit

class NavigationView: UIView {
    
    @IBInspectable var hasNewNotifications:Bool = false {
      didSet {
          HasNewNotification(hasNewNotifications)
      }
    }
    
    @IBInspectable var ShowNotifications:Bool = true {
      didSet {
        HasNewNotification(ShowNotifications)
        ViewNotification.alpha = ShowNotifications ? 1:0
      }
    }
    
    lazy var ProfileImage : ImageAddBorder = {
        let ImageView = ImageAddBorder()
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(22)
        ImageView.Image.image = UIImage(named: "Profile")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(44)).isActive = true
        ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        ImageView.AddBorder(Color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), width: 1.5)
        return ImageView
    }()
    
    lazy var LogoImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Group 58357")
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Image
    }()
    
    
    lazy var ViewNotification : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        View.addSubview(NotificationButton)
        NotificationButton.centerYAnchor.constraint(equalTo: View.centerYAnchor).isActive = true
        NotificationButton.trailingAnchor.constraint(equalTo: View.trailingAnchor).isActive = true
        NotificationButton.widthAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        NotificationButton.heightAnchor.constraint(equalToConstant: ControlWidth(28)).isActive = true
        
        View.addSubview(NotificationHasNew)
        NotificationHasNew.layer.cornerRadius = ControlWidth(5)
        NotificationHasNew.heightAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        NotificationHasNew.widthAnchor.constraint(equalTo: NotificationHasNew.heightAnchor).isActive = true
        NotificationHasNew.topAnchor.constraint(equalTo: NotificationButton.topAnchor,constant: ControlY(2)).isActive = true
        NotificationHasNew.centerXAnchor.constraint(equalTo: NotificationButton.trailingAnchor,constant: ControlY(-4)).isActive = true
        return View
    }()
    
    lazy var NotificationButton : UIImageView = {
        let Image = UIImageView()
        Image.contentMode = .scaleAspectFit
        Image.isUserInteractionEnabled = true
        Image.image = UIImage(named: "Notification")
        Image.translatesAutoresizingMaskIntoConstraints = false
        return Image
    }()
    
    lazy var NotificationHasNew : UIView = {
        let View = UIView()
        View.alpha = 0
        View.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    func HasNewNotification(_ HasNew:Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.NotificationHasNew.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: []) {
        self.NotificationHasNew.alpha = HasNew ? 1:0
        self.NotificationHasNew.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        }
    }
    
    lazy var BottomStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ProfileImage,LogoImage,ViewNotification])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
    addSubview(BottomStack)
    BottomStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    BottomStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    BottomStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    BottomStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
