//
//  Welcome.swift
//  SHARMIVAL
//
//  Created by Emojiios on 06/09/2022.
//

import UIKit
import CoreLocation
import UserNotifications

class WelcomeScreen: UIViewController, TutorialPageViewControllerDelegate  {
    
    
    var tutorialPageViewController: ScreenPageView? {
    didSet {
    tutorialPageViewController?.tutorialDelegate = self
    }
    }
    
    var currentPage = Int()
    static let PageScrollEnabled = NSNotification.Name(rawValue: "PageScrollEnabled")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))
        
        view.addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: LogoImage.bottomAnchor,constant: ControlY(25)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: ControlY(-200)).isActive = true
        
        view.addSubview(pageControl)
        pageControl.topAnchor.constraint(equalTo: StackItems.bottomAnchor,constant: ControlY(15)).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        
        view.addSubview(StackButton)
        StackButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: ControlY(-90)).isActive = true
        StackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
        StackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
        StackButton.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true

        NotificationCenter.default.addObserver(self, selector: #selector(Permission), name: AppDelegate.DidBecomeActive , object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageControl.set(progress: currentPage, animated: false)
        SetUpEnum()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Permission()
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
    }
    
    @objc func Permission() {
        if currentPage == 2 && NotificationEnabled == false {
        PermissionNotification()
        }
        
        if currentPage == 3 && PermissionLocation == false {
        LocationPermission()
        }
    }
    
    lazy var LogoImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Group 58357")
        return Image
    }()
    
    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        return Label
    }()
    
    func TopLabelText(_ Text1:String,_ Font1:UIFont?,_ Text2:String ,_ Font2:UIFont?,_ Text3:String = "",_ Font3:UIFont? = UIFont()) {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: Text1, attributes: [
            .font: Font1 ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: Text2, attributes: [
            .font: Font2 ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: Text3, attributes: [
            .font: Font3 ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        TopLabel.numberOfLines = 0
        TopLabel.backgroundColor = .clear
        TopLabel.attributedText = attributedString
    }
    
    lazy var LabelMessage : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(16))
        return Label
    }()
    
    lazy var ImageMessage : UIImageView = {
        let Image = UIImageView()
        Image.contentMode = .top
        Image.clipsToBounds = true
        Image.backgroundColor = .clear
        Image.translatesAutoresizingMaskIntoConstraints = false
        Image.heightAnchor.constraint(equalToConstant: ControlWidth(150)).isActive = true
        return Image
    }()
    
    lazy var pageControl : WOPageControl = {
        let Page = WOPageControl()
        Page.tintColor = #colorLiteral(red: 0.1118487329, green: 0.1118487329, blue: 0.1118487329, alpha: 1)
        Page.numberOfPages = 4
        Page.padding = ControlX(15)
        Page.enableTouchEvents = true
        Page.radius = ControlWidth(2.5)
        Page.currentPageTintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Page.translatesAutoresizingMaskIntoConstraints = false
        Page.transform = "lang".localizable == "ar" ? CGAffineTransform(rotationAngle: .pi) : .identity
        return Page
    }()
    
    lazy var ButtonNext : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.layer.cornerRadius = ControlWidth(8)
        Button.addTarget(self, action: #selector(ActionNext), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionNext() {
        if currentPage < 3 {
        if currentPage == 1 && CheckboxButton.Button.tag != 1 {
        CheckboxButton.Shake()
        tutorialPageViewController?.scrollToViewController(index: 1)
        }else if currentPage == 2 && NotificationEnabled == false {
        self.ShowAlertNotification = true
        self.PermissionNotification()
        self.tutorialPageViewController?.scrollToViewController(index: 2)
        }else{
        tutorialPageViewController?.scrollToViewController(index: currentPage + 1)
        }
        }else{
            
        if currentPage == 3 && PermissionLocation == false {
        self.ShowAlertLocation = true
        LocationPermission()
        }else{
        FirstController(MyAccountVC())
        }
            
        }
    }
    

    lazy var ButtonBack : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = .clear
        Button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Button.setTitle("Pervious".localizable, for: .normal)
        Button.layer.borderWidth = ControlWidth(2)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.addTarget(self, action: #selector(ActionBack), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()
    
    @objc func ActionBack() {
        if currentPage > 0 {
        tutorialPageViewController?.scrollToViewController(index: currentPage - 1)
        }
    }

    func SetUpEnum()  {

    switch self.currentPage {
    case 0:
        
    self.ButtonNext.isEnabled = true
    self.ButtonBack.isHidden = true
    self.ButtonNext.isHidden = false
    self.ButtonNext.setTitle("Next".localizable, for: .normal)
        
    self.ImageMessage.isHidden = true
    self.CheckboxButton.isHidden = true
    self.LabelMessage.text = "WelcomeMessage1".localizable
    self.LabelMessage.addInterlineSpacing(spacingValue: ControlWidth(3))
    self.TopLabelText("Where".localizable.uppercased(),UIFont(name: "CocoGothic-Light", size: ControlWidth(20))
                      ,"Creativity & Culture meet Care".localizable.uppercased(),UIFont(name: "Gotham-Bold", size: ControlWidth(20)))
        
    case 1:

    self.ButtonBack.isHidden = false
    self.ButtonNext.isHidden = false
    self.ButtonNext.setTitle("Next".localizable, for: .normal)

    self.ImageMessage.isHidden = true
    self.CheckboxButton.isHidden = false
    self.LabelMessage.text = "WelcomeMessage2".localizable
    self.LabelMessage.addInterlineSpacing(spacingValue: ControlWidth(3))
        self.TopLabelText("SHARMIVAL".localizable.uppercased(),UIFont(name: "CocoGothic-Bold", size: ControlWidth(20))
                          ,"respects your privacy".localizable.uppercased(),UIFont(name: "CocoGothic-Light", size: ControlWidth(20)))

    case 2:
    self.ButtonBack.isHidden = false
    self.ButtonNext.isHidden = false
        
    self.ImageMessage.isHidden = false
    self.CheckboxButton.isHidden = true
    self.LabelMessage.text = "WelcomeMessage3".localizable
    self.ImageMessage.image = UIImage(named: "svgexport-15")
    self.ButtonNext.setTitle("Next".localizable, for: .normal)
    self.LabelMessage.addInterlineSpacing(spacingValue: ControlWidth(3))
        self.TopLabelText("DON’T".localizable.uppercased(),UIFont(name: "CocoGothic-Bold", size: ControlWidth(20))
                          ,"MISS OUT".localizable.uppercased(),UIFont(name: "CocoGothic-Light", size: ControlWidth(20)))

    case 3:
    self.ButtonNext.isEnabled = true
    self.ButtonBack.isHidden = false
    self.ButtonNext.isHidden = false
        
    self.ImageMessage.isHidden = false
    self.CheckboxButton.isHidden = true
    self.LabelMessage.text = "WelcomeMessage4".localizable
    self.ImageMessage.image = UIImage(named: "svgexport-16")
    self.ButtonNext.setTitle("Submit".localizable, for: .normal)
    self.LabelMessage.addInterlineSpacing(spacingValue: ControlWidth(3))
        self.TopLabelText("FIND".localizable.uppercased(),UIFont(name: "CocoGothic-Bold", size: ControlWidth(20))
                          ,"YOUR WAY".localizable.uppercased(),UIFont(name: "CocoGothic-Light", size: ControlWidth(20))
                          ,"AROUND".localizable.uppercased(),UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)))
            
    default:
    break
    }

    }
    
    lazy var StackButton : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ButtonBack,ButtonNext])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(20)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    // MARK : - Set UP View
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,LabelMessage,CheckboxButton,ImageMessage])
        Stack.axis = .vertical
        Stack.spacing = ControlX(5)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .fillProportionally
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    

    // MARK : - Set UP View Frist
    lazy var CheckboxButton : Checkbox = {
        let Button = Checkbox(type: .system)
        
        let attributedString = NSMutableAttributedString(string: "I understand & accept the".localizable, attributes: [
            .font: UIFont(name: "Poppins-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "terms".localizable, attributes: [
            .font: UIFont(name: "Poppins-Medium", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) ,
            .underlineStyle: NSUnderlineStyle.thick.rawValue
        ]))
        
        Button.Label.numberOfLines = 0
        Button.Label.backgroundColor = .clear
        Button.Label.attributedText = attributedString
        Button.Button.addAction(for: .touchUpInside) { _ in
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
        }
        return Button
    }()
    
    func IsScrollEnabled() -> Bool {
        if currentPage == 1 {
        return CheckboxButton.Button.tag == 0 ? false : true
        }else if currentPage == 2 {
        return self.NotificationEnabled
        }else if currentPage == 3 {
        return self.PermissionLocation
        }else{
        return true
        }
    }
    

    var NotificationEnabled = false
    var ShowAlertNotification = false
    func PermissionNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if !granted {
        self.NotificationEnabled = false
            
        if self.ShowAlertNotification {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Allow notification Access".localizable, message: "Allow notification access in your device settings.".localizable, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Settings".localizable, style: UIAlertAction.Style.default, handler: { action in
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {return}
        if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
        print("Settings opened: \(success)")
        })
        }
        }))
        alert.addAction(UIAlertAction(title: "Close".localizable, style: UIAlertAction.Style.default, handler: nil))
            
        self.ImageMessage.Shake()
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
        self.present(alert, animated: true, completion: nil)
        }
        }
            
        }else{
        self.NotificationEnabled = true
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
        }
        }
    }

    var PermissionLocation = false
    var ShowAlertLocation = false
    func LocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
        CLLocationManager().requestAlwaysAuthorization()
        CLLocationManager().startUpdatingLocation()
        PermissionLocation = false
        DispatchQueue.main.async {
                
        if !self.PermissionLocation && self.ShowAlertLocation {
            let alertController = UIAlertController(title: "Location Permission Required".localizable, message: "Please enable location permissions in settings.".localizable, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "Settings".localizable, style: .default, handler: {(cAlertAction) in
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }))
            
        alertController.addAction(UIAlertAction(title: "Close".localizable, style: .cancel))

        self.ImageMessage.Shake()
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
        self.present(alertController, animated: true, completion: nil)
        }
                
        }
        case .authorizedAlways, .authorizedWhenInUse:
        PermissionLocation = true
        NotificationCenter.default.post(name: WelcomeScreen.PageScrollEnabled, object: nil)
        @unknown default:
            break
        }
        } else {
        PermissionLocation = false
        }
    }
    
    func didTapNextButton(_ sender: Any) {
        tutorialPageViewController?.scrollToNextViewController()
    }
    
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView,
            didUpdatePageCount count: Int) {
            pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: ScreenPageView, didUpdatePageIndex index: Int) {
        pageControl.set(progress: index, animated: false)
    }
}

