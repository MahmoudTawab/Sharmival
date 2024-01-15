//
//  LaunchScreen.swift
//  SHARMIVAL
//
//  Created by Emojiios on 06/09/2022.
//

import UIKit
import FirebaseAuth
import CoreLocation
import UserNotifications

class LaunchScreen: UIViewController {
    
    var PresentScreen = UIViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        AddDevice()
        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))

        view.addSubview(ImageView)
        ImageView.frame = CGRect(x: 0, y: LogoImage.frame.maxY + ControlY(35), width: view.frame.width, height: view.frame.height - (LogoImage.frame.maxY + ControlY(35)))
    }
    
    lazy var LogoImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Group 58357")
        return Image
    }()
    
    lazy var ImageView:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "BG")
        return Image
    }()
    

    var Device : DeviceModel?
    func AddDevice() {
    let url = defaults.string(forKey: "API") == "" ? "https://Sharmival.azurewebsites.net/" : defaults.string(forKey: "API") ?? "https://Sharmival.azurewebsites.net/"
    let api = "\(url  + ApiAddDevice)"

    let modelName = UIDevice.modelName
    let version = UIDevice.current.systemVersion
    let fireToken = defaults.string(forKey: "fireToken") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["token": "I57sMTbkmuYaILn9MxDEdb0R6rVqG2aW8EfSQNfpb1k",
                                   "appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "Platform": "I",
                                   "lang": "lang".localizable,
                                   "fireToken": fireToken,
                                   "deviceID": udid,
                                   "deviceModel": modelName,
                                   "manufacturer": "Iphone",
                                   "osVersion": version,
                                   "versionCode": "1"]

    PostAPI(timeout: 20,api: api, token: nil, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.Device = DeviceModel(dictionary: data)
    self.SetUpScreen()
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.SetUpScreen()
    }
    }
    
    func SetUpScreen() {
    DispatchQueue.main.async {
    if defaults.string(forKey: "uid") != nil {
    self.PresentScreen = TabBarController()
    self.perform(#selector(self.IfIsUser), with: self, afterDelay: 1)
    }else {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
    
    DispatchQueue.main.async {
    if CLLocationManager.locationServicesEnabled() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined, .restricted, .denied:
    self.ScreenPresent(false)
    case .authorizedAlways, .authorizedWhenInUse:
    self.ScreenPresent(granted)
    @unknown default:
    break
    }
    } else {
    self.ScreenPresent(false)
    }
    }
        
    }
    }
    }
    }
    
    func ScreenPresent(_ granted:Bool) {
        if !granted {
        self.PresentScreen = LocalizableScreen()
        self.signOut()
        self.perform(#selector(self.IfIsUser), with: self, afterDelay: 1)
        }else{
        self.PresentScreen = MyAccountVC()
        self.signOut()
        self.perform(#selector(self.IfIsUser), with: self, afterDelay: 1)
        }
    }

    
    @objc func IfIsUser() {
    FirstController(self.PresentScreen)
    UIView.animate(withDuration: 0.5) {
    self.ImageView.frame = CGRect(x: 0, y: self.view.frame.height, width:self.ImageView.frame.width, height: self.ImageView.frame.height)
    }
    }
    
    
    func signOut() {
    try? Auth.auth().signOut()
    defaults.removeObject(forKey: "uid")
    defaults.removeObject(forKey: "sqlId")
    defaults.removeObject(forKey: "carnavalId")
    defaults.removeObject(forKey: "profileImage")
    defaults.removeObject(forKey: "hasNewNotifications")
    defaults.synchronize()
    }
}
