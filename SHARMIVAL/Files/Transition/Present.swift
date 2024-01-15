//
//  Present.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 12/07/2021.
//

import UIKit
import SDWebImage

class ViewController : UIViewController  {
        
    let TopHeight = UIApplication.shared.statusBarFrame.height
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    ViewDots.removeFromSuperview()
    view.addSubview(ViewDots)
    self.ViewDots.SpinnerView.startAnimating()

    if let ProfileImage = defaults.string(forKey: "profileImage") {
    self.TopView.ProfileImage.Image.sd_setImage(with: URL(string: ProfileImage), placeholderImage: UIImage(named: "Profile"))
    }
                
    self.TopView.hasNewNotifications = defaults.bool(forKey: "hasNewNotifications")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ViewNoData)
        ViewNoData.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlWidth(20)).isActive = true
        ViewNoData.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlWidth(-20)).isActive = true
        ViewNoData.topAnchor.constraint(equalTo: view.topAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(110):ControlWidth(150)).isActive = true
        ViewNoData.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: self.hidesBottomBarWhenPushed != true ? ControlWidth(-130):ControlWidth(-100)).isActive = true
    }
    
    lazy var ViewDots : DotsView = {
        let View = DotsView(frame: view.bounds)
        View.backgroundColor = .clear
        View.ViewPresent = self
        View.alpha = 0
        return View
    }()
    
    lazy var TopView : NavigationView = {
        let View = NavigationView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        View.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        View.ProfileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PresentToPersonalVC)))
        View.NotificationButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PresentToNotificationVC)))
        return View
    }()
    
    @objc func PresentToPersonalVC() {
    Present(ViewController: self, ToViewController: PersonalVC())
    }
    
    @objc func PresentToNotificationVC() {
    Present(ViewController: self, ToViewController: NotificationVC())
    }
    
    lazy var TopBarImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Mask Group")
        ImageView.transform = CGAffineTransform(rotationAngle: .pi)
        return ImageView
    }()
    
    func SetUpTopBarImage(_ height:CGFloat = 60,_ Animate:Bool = true) {
        view.addSubview(TopBarImage)
        self.TopBarImage.frame = CGRect(x: 0, y: ControlHeight(-height), width: self.view.frame.width, height:  ControlHeight(height))
        
        if Animate {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.9) {
        self.TopBarImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  ControlHeight(height))
        }
        }
        }else{
        self.TopBarImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  ControlHeight(height))
        }
    }
    
    lazy var WhatsUpButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 0
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "Group 57663"), for: .normal)
        Button.addTarget(self, action: #selector(ActionWhatsUp), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionWhatsUp() {
    let phone = "+201204474410"
//        defaults.string(forKey: "WhatsApp") ?? ""
    guard let whatsappURL = URL(string: "https://api.whatsapp.com/send?phone=\(phone)&text=_Good%20Job%20Tawab_") else {return}
    if UIApplication.shared.canOpenURL(whatsappURL) {
    if #available(iOS 10.0, *) {
    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
    }else {
    UIApplication.shared.openURL(whatsappURL)
    }
    }
    }
    
    lazy var CoinsButton : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 0
        Button.backgroundColor = .clear
        Button.setBackgroundImage(UIImage(named: "Group 58578"), for: .normal)
        Button.addTarget(self, action: #selector(ActionCoins), for: .touchUpInside)
        return Button
    }()
    
    
    @objc func ActionCoins() {
    Present(ViewController: self, ToViewController: CurrencyVC())
    }
    
    func SetUpButton() {
        if WhatsUpButton.alpha == 0 && CoinsButton.alpha == 0 {
        self.WhatsUpButton.frame = CGRect(x: self.view.frame.width + ControlWidth(75), y: self.view.frame.height - ControlWidth(220), width: ControlWidth(60), height: ControlWidth(60))
        self.CoinsButton.frame = CGRect(x: self.view.frame.width + ControlWidth(75), y: self.view.frame.height - ControlWidth(150), width: ControlWidth(60), height: ControlWidth(60))
        self.view.addSubview(self.WhatsUpButton)
        self.view.addSubview(self.CoinsButton)


        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
        self.CoinsButton.alpha = 1
        self.CoinsButton.frame = CGRect(x: self.view.frame.width - ControlWidth(75), y: self.view.frame.height - ControlWidth(220), width: ControlWidth(64), height: ControlWidth(64))
        }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: []) {
        self.WhatsUpButton.alpha = 1
        self.WhatsUpButton.frame = CGRect(x: self.view.frame.width - ControlWidth(75), y: self.view.frame.height - ControlWidth(150), width: ControlWidth(64), height: ControlWidth(64))
        }
        }
        }
    }
    
    lazy var ViewNoData : ViewIsError = {
        let View = ViewIsError()
        View.backgroundColor = .clear
        View.isHidden = true
        View.ImageIcon = "ErrorService"
        View.TextRefresh = "Try Again".localizable
        View.MessageTitle = "Something went wrong".localizable
        View.MessageDetails = "Something went wrong while processing your request, please try again later".localizable
        View.translatesAutoresizingMaskIntoConstraints =  false
        return View
    }()
    
    var ViewNoDataShow = false
    func SetUpIsError(_ error:String ,_ Show:Bool ,_ selector: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        self.ViewDots.endRefreshing(){}
        }
        
        if !ViewNoDataShow {
        if Show {
        self.ViewNoDataShow = true
        self.ViewNoData.isHidden = false
        self.ViewNoData.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
        self.ViewNoData.transform = .identity})
        self.ViewNoData.RefreshButton.addAction(for: .touchUpInside) { (button) in
        selector()
        }
        }
        }
    }

}

