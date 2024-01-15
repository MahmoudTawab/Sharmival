//
//  SettingVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit
import FirebaseAuth

class SettingVC: ViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var lang : String?
    var SettingData:Setting?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        GetDataSetting()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(ViewDismiss)
        ViewDismiss.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(5)).isActive = true
        ViewDismiss.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        ViewDismiss.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        ViewDismiss.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        view.addSubview(StackItems)
        StackItems.heightAnchor.constraint(equalToConstant: ControlWidth(220)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        StackItems.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    
        view.addSubview(LocalizableView)
        self.LocalizableView.frame = view.bounds
        
        view.addSubview(LocalizableConstant)
        LocalizableConstant.frame = CGRect(x: ControlX(-15), y: self.view.frame.height, width: self.view.frame.width - ControlX(30), height: self.view.frame.height / 2.2)
    }
        
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.TextLabel = "Setting".localizable
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(35), height: ControlWidth(35))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Language
    lazy var ButtonLanguage : UIButton = {
        let Button = UIButton(type: .system)
        Button.clipsToBounds = true
        Button.backgroundColor = #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)
        Button.layer.cornerRadius = ControlX(10)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setTitle("Language".localizable, for: .normal)
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.addTarget(self, action: #selector(ActionLanguage), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(18))
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(20), bottom: 0, right: ControlWidth(15))
        
        Button.addSubview(ViewLanguage)
        ViewLanguage.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
        ViewLanguage.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ViewLanguage.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        ViewLanguage.trailingAnchor.constraint(equalTo: Button.trailingAnchor,constant: ControlX(-15)).isActive = true
        return Button
    }()
    
    @objc func ActionLanguage() {
        if LocalizableView.alpha == 0 {
        UIView.animate(withDuration: 0.5) {
        self.LocalizableView.alpha = 1
        self.LocalizableConstant.alpha = 1
        self.LocalizableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5045327946)
        self.LocalizableView.frame = self.view.bounds
        self.LocalizableConstant.frame = CGRect(x: ControlX(15), y: self.view.center.y - (self.view.frame.height / 4.4), width: self.view.frame.width - ControlX(30), height: self.view.frame.height / 2.2)
        }
        }
    }
    
    lazy var ViewLanguage : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    
    lazy var LocalizableView : UIView = {
        let View = UIView()
        View.alpha = 0
        View.isUserInteractionEnabled = true
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LocalizableHidden)))
        return View
    }()
    
    lazy var LocalizableConstant : UIView = {
        let View = UIView()
        View.alpha = 0
        View.clipsToBounds = true
        View.backgroundColor = .white
        View.layer.cornerRadius = ControlX(10)
        
        View.addSubview(LocalizableCollection)
        LocalizableCollection.topAnchor.constraint(equalTo: View.topAnchor,constant: ControlX(10)).isActive = true
        LocalizableCollection.bottomAnchor.constraint(equalTo: View.bottomAnchor,constant: ControlX(-10)).isActive = true
        LocalizableCollection.leadingAnchor.constraint(equalTo: View.leadingAnchor,constant: ControlX(25)).isActive = true
        LocalizableCollection.trailingAnchor.constraint(equalTo: View.trailingAnchor,constant: ControlX(-25)).isActive = true
        
        View.addSubview(LocalizableCenter)
        LocalizableCenter.widthAnchor.constraint(equalToConstant: ControlWidth(110)).isActive = true
        LocalizableCenter.heightAnchor.constraint(equalTo: LocalizableCenter.widthAnchor).isActive = true
        LocalizableCenter.centerYAnchor.constraint(equalTo: View.centerYAnchor).isActive = true
        LocalizableCenter.centerXAnchor.constraint(equalTo: View.centerXAnchor).isActive = true
        return View
    }()
    
    @objc func LocalizableHidden() {
        if LocalizableView.alpha == 1 {
        UIView.animate(withDuration: 0.5) {
        self.LocalizableView.alpha = 0
        self.LocalizableConstant.alpha = 0
        self.LocalizableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.LocalizableConstant.frame = CGRect(x: ControlX(15), y: self.view.frame.height, width: self.view.frame.width - ControlX(30), height: self.view.frame.height / 2.2)
        }
        }
    }
    
    lazy var LocalizableCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(55)
        ImageView.image = UIImage(named: "Einglish")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLocalizableCenter)))
        return ImageView
    }()
    
    @objc func ActionLocalizableCenter() {
        LocalizableHidden()
        if lang != "en" {
        lang = "en"
        IfSwitchUpdate = false
        UpdateDataSetting()
        }
    }
    
    let CircleCellID = "CircleCellID"
    var LanguageData = [Language(id: 2, flag: "Arabic", title: "ar"),
                        Language(id: 3, flag: "Français", title: "fr"),
                        Language(id: 9, flag: "Russian", title: "ru"),
                        Language(id: 10,flag: "Spain", title: "es"),
                        Language(id: 11,flag: "Ukraine", title: "uk"),
                        Language(id: 12,flag: "Italy", title: "it")]
    
    lazy var LocalizableCollection: UICollectionView = {
        let layout = CircleLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.clipsToBounds = false
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(LocalizableCircleCell.self, forCellWithReuseIdentifier: CircleCellID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LanguageData.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCellID, for: indexPath) as! LocalizableCircleCell
    cell.backgroundColor = .clear
    cell.clipsToBounds = true
    cell.layer.cornerRadius = cell.frame.height / 2
    cell.ImageView.image = UIImage(named: LanguageData[indexPath.item].flag)
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LocalizableHidden()
        if lang != LanguageData[indexPath.item].title {
        lang = LanguageData[indexPath.item].title
        IfSwitchUpdate = false
        UpdateDataSetting()
        }
    }
    
    // MARK: - Notification
    lazy var ButtonNotification : UIButton = {
        let Button = UIButton(type: .system)
        Button.clipsToBounds = true
        Button.backgroundColor = #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)
        Button.layer.cornerRadius = ControlX(10)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setTitle("Notification".localizable, for: .normal)
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.titleLabel?.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(18))
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(20), bottom: 0, right: ControlWidth(15))
        
        Button.addSubview(SwitchNotification)
        SwitchNotification.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
        SwitchNotification.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        SwitchNotification.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        SwitchNotification.trailingAnchor.constraint(equalTo: Button.trailingAnchor,constant: ControlX(-15)).isActive = true
        return Button
    }()
    
    lazy var SwitchNotification : UISwitch = {
    let Switch = UISwitch()
    Switch.onTintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
    Switch.thumbTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    Switch.contentHorizontalAlignment = .center
    Switch.translatesAutoresizingMaskIntoConstraints = false
    Switch.addTarget(self, action: #selector(Update), for: .valueChanged)
    return Switch
    }()
    
    var IfSwitchUpdate = false
    @objc func Update() {
    IfSwitchUpdate = true
    SettingData?.receiveNotifications = !(SettingData?.receiveNotifications ?? false)
    UpdateDataSetting()
    }
    

    // MARK: - LogOut
    lazy var ButtonLogOut : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)
        Button.setTitle("Log Out".localizable, for: .normal)
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.addTarget(self, action: #selector(ActionLogOut), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(18))
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: ControlWidth(20), bottom: 0, right: ControlWidth(15))
        return Button
    }()
    
    lazy var ImageLogOut : UIImageView = {
        let ImageView = UIImageView()
        ImageView.tintColor = .white
        ImageView.clipsToBounds = true
        ImageView.contentMode = .center
        ImageView.backgroundColor = .clear
        ImageView.image = UIImage(named: "Path")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.transform = "lang".localizable == "ar" ?  CGAffineTransform(rotationAngle: (.pi / 2)) : CGAffineTransform(rotationAngle: -(.pi / 2))
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(70)).isActive = true
        return ImageView
    }()

    lazy var StackLogOut : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ButtonLogOut,ImageLogOut])
        Stack.alignment = .center
        Stack.axis = .horizontal
        Stack.clipsToBounds = true
        Stack.backgroundColor = #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)
        Stack.spacing = ControlX(20)
        Stack.distribution = .equalSpacing
        Stack.layer.cornerRadius = ControlX(10)
        Stack.isUserInteractionEnabled = true
        Stack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLogOut)))
        return Stack
    }()
    
    @objc func ActionLogOut() {
    ShowMessageAlert("ErrorIcon", "Log Out".localizable, "Are You Sure You Want to log out of your account".localizable, false, self.signOut , "Log Out".localizable)
    }
    
    func signOut() {
    try? Auth.auth().signOut()
    defaults.removeObject(forKey: "uid")
    defaults.removeObject(forKey: "sqlId")
    defaults.removeObject(forKey: "carnavalId")
    defaults.removeObject(forKey: "profileImage")
    defaults.removeObject(forKey: "hasNewNotifications")
    defaults.synchronize()
    FirstController(MyAccountVC())
    }
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ButtonLanguage,ButtonNotification,StackLogOut])
        Stack.isHidden = true
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(25)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    @objc func GetDataSetting() {
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
        
    let api = "\(url + GetSetting)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.SetUpData(data)
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.IfNoData(Data:false)
    self.SetUpIsError(error, true) {
    self.GetDataSetting()}
    }
    }
    
    
    func SetUpData(_ dictionary:[String:Any]) {
    IfNoData(Data:true)
    self.SettingData = Setting(dictionary: dictionary)
    SwitchNotification.isOn = self.SettingData?.receiveNotifications ?? false
        
    if let Lang = self.SettingData?.langList.firstIndex(where: {$0.id == self.SettingData?.lang}) {
    self.lang = self.SettingData?.langList[Lang].title
    
    if let url = self.SettingData?.langList[Lang].flag {
    guard let UrlLanguage = URL(string: url) else { return }
    let svgView = UIView(svgURL: UrlLanguage) { (svgLayer) in
    svgLayer.resizeToFit(self.ViewLanguage.bounds)}
    self.ViewLanguage.addSubview(svgView)
    }
    }
        
    }
    
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    StackItems.isHidden = !Data
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetDataSetting), for: .touchUpInside)
    self.ViewDots.endRefreshing {}
    }
    
    
    func UpdateDataSetting() {
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
            
    let api = "\(url + UpdateSetting)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let receiveNotifications = SettingData?.receiveNotifications ?? false

    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "receiveNotifications": receiveNotifications,
                                    "lang": lang ?? "en"]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.SetLanguage()
    self.ViewDots.endRefreshing {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    if error != "" && self.IfSwitchUpdate == true {
    self.IfSwitchUpdate = false
    self.SwitchNotification.isOn = !self.SwitchNotification.isOn
    self.SettingData?.receiveNotifications = !(self.SettingData?.receiveNotifications ?? false)
    }
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
    
    @objc func SetLanguage() {
    guard let lang = lang else{return}
    if MOLHLanguage.currentAppleLanguage() != lang {
    MOLH.setLanguageTo(lang)
    self.ViewDots.endRefreshing() {MOLH.reset()}
    }
    }
    

}
