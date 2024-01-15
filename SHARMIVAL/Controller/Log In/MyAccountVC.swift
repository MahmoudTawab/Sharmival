//
//  MyAccountVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import AuthenticationServices

class MyAccountVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))
        
        view.addSubview(BottomBackgroundImage)
        BottomBackgroundImage.frame = CGRect(x: ControlX(30), y: view.frame.height / 1.5, width: view.frame.width - ControlX(30), height: view.frame.height / 3)
        
        view.addSubview(BottomBarImage)
        self.BottomBarImage.frame = CGRect(x: 0, y: self.view.frame.height - ControlHeight(60), width: self.view.frame.width, height: ControlHeight(60))

        view.addSubview(StackItems)
        StackItems.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: ControlY(-90)).isActive = true
        StackItems.topAnchor.constraint(equalTo: LogoImage.bottomAnchor,constant: ControlY(30)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
    }

    lazy var LogoImage : UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Group 58357")
        return Image
    }()
    
    lazy var BottomBarImage:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Mask Group")
        return Image
    }()
    
    lazy var BottomBackgroundImage:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Mask Group 46")
        return Image
    }()
    

    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "My".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Account".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    
    lazy var LabelMessage : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.addInterlineSpacing(spacingValue: ControlWidth(3))
        Label.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(16))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(80)).isActive = true
        Label.text = "Sign up for your Sharmival account to unlock extra features such as your location tracking.".localizable
        return Label
    }()
    
    lazy var Signin : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Sign in".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignin), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSignin() {
    defaults.set("E", forKey: "signUpType")
    Present(ViewController: self, ToViewController: SignInVC())
    }

    lazy var SignUp : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = .clear
        Button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Button.layer.borderWidth = ControlWidth(2)
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.setTitle("Sign up".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()
    
    @objc func ActionSignUp() {
    defaults.set("E", forKey: "signUpType")
    Present(ViewController: self, ToViewController: SignUpVC())
    }
    

    lazy var ButtonGuest : UIButton = {
        let Button = UIButton(type: .system)
        Button.alpha = 0
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Continue as a".localizable, attributes: [
            .font: UIFont(name: "Poppins-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "guest".localizable, attributes: [
            .font: UIFont(name: "Poppins-Medium", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Button.backgroundColor = .clear
        Button.titleLabel?.numberOfLines = 0
        Button.setAttributedTitle(attributedString, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Button
    }()
    
    
    
    lazy var ViewOR : UIView = {
        let View = UIView()
        View.backgroundColor = .clear
        View.translatesAutoresizingMaskIntoConstraints = false

        View.addSubview(ViewLineOR)
        View.addSubview(LabelOR)
        LabelOR.topAnchor.constraint(equalTo: View.topAnchor).isActive = true
        LabelOR.bottomAnchor.constraint(equalTo: View.bottomAnchor).isActive = true
        LabelOR.centerXAnchor.constraint(equalTo: View.centerXAnchor).isActive = true
        LabelOR.widthAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        
        ViewLineOR.heightAnchor.constraint(equalToConstant: ControlWidth(1)).isActive = true
        ViewLineOR.centerYAnchor.constraint(equalTo: LabelOR.centerYAnchor).isActive = true
        ViewLineOR.leadingAnchor.constraint(equalTo: View.leadingAnchor).isActive = true
        ViewLineOR.trailingAnchor.constraint(equalTo: View.trailingAnchor).isActive = true
        
        View.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return View
    }()
    
    lazy var ViewLineOR : UIView = {
        let View = UIView()
        View.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    lazy var LabelOR : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .white
        Label.text = "Or".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Medium" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var Google : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.931889832, green: 0.931889832, blue: 0.931889832, alpha: 1)
        Button.clipsToBounds = true
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.black, for: .normal)
        Button.setImage(UIImage(named: "Google"), for: .normal)
        Button.setTitle("   " + "Google".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionGoogle), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 25)
        Button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: ControlWidth(16))
        return Button
    }()
    
    @objc func ActionGoogle() {
        SignInGoogle()
    }

    lazy var Facebook : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.1952412724, green: 0.5290824175, blue: 0.9440533519, alpha: 1)
        Button.tintColor = .white
        Button.clipsToBounds = true
        Button.contentHorizontalAlignment = .center
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.setImage(UIImage(named: "Facebook"), for: .normal)
        Button.setTitle("   " + "Facebook".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionFacebook), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 25)
        Button.titleLabel?.font = UIFont(name: "Poppins-Regular", size: ControlWidth(16))
        return Button
    }()
    
    @objc func ActionFacebook() {
        SignFacebook()
    }
    
    lazy var StackSocialMedia : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Facebook,Google])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(15)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Stack
    }()
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,LabelMessage,Signin,SignUp,ButtonGuest,ViewOR,StackSocialMedia])
        Stack.axis = .vertical
        Stack.spacing = ControlX(5)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    
    func LoginSocial(_ uid:String ,_ Social:String ,_ email:String ,_ phone:String ,_ ProfileUrl:URL? ,_ lastName:String ,_ firstName:String) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let api = "\(url + ApiLogin)"
            
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "platform": "I",
                                    "deviceID": udid,
                                    "uid": uid]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.ViewDots.endRefreshing {}
    HomeVC.Main = MainScreen(dictionary: data)
    SaveProfile(MainScreen(dictionary: data), uid)
        
    if MainScreen(dictionary: data).isUser == false {
    let SignUp = SignUpVC()
    SignUp.uid = uid
    SignUp.EmailTF.text = email
    SignUp.PhoneNumberTF.text = phone
    SignUp.LastNameTF.text = lastName
    SignUp.FirstNameTF.text = firstName
    defaults.set(Social, forKey: "signUpType")
    SignUp.isValidNumber = true
    Present(ViewController: self, ToViewController: SignUp)
    }else{
    FirstController(TabBarController())
    }
        
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error, {})
    }
    }
}


// Sign in Google
extension MyAccountVC {
    
    func SignInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in

        if error != nil {
        return
        }
            
        guard let accessToken = user?.user.accessToken.tokenString , let idToken = user?.user.idToken?.tokenString
        else {
        return
        }

        guard let User = user?.user.profile else { return }
        let emailAddress = User.email
        let givenName = User.givenName ?? ""
        let familyName = User.familyName ?? ""
        let profilePicUrl = User.imageURL(withDimension: 320)
    //  let fullName = user.name

            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
        Auth.auth().signIn(with: credential) { authResult, error in
        self.ViewDots.beginRefreshing()
            
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        guard let uid = authResult?.user.uid else { return }
        self.LoginSocial(uid, "G", emailAddress ,"" , profilePicUrl , familyName, givenName)
        }
        }
    }
}
// Sign in Facebook
extension MyAccountVC {
    func SignFacebook() {
        LoginManager().logIn(permissions: ["email"], from: self) { (result,err) in
        if let error = err {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

            
        if result?.isCancelled == true {return}
        guard let accessToken = AccessToken.current else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)

        Auth.auth().signIn(with: credential) { authResult, error in
        if let error = error {
        self.ViewDots.endRefreshing(error.localizedDescription, .error) {}
        return
        }

        self.ViewDots.beginRefreshing()
        GraphRequest(graphPath: "/me", parameters: ["fields": "email, first_name, last_name, name, picture.width(480).height(480)"]).start { (connection,result,err) in
        if let Error = err {
        self.ViewDots.endRefreshing(Error.localizedDescription, .error) {}
        return
        }
            
        if let data = result as? NSDictionary {
        guard let uid = authResult?.user.uid else { return }
        let firstName  = data.object(forKey: "first_name") as? String ?? ""
        let lastName  = data.object(forKey: "last_name") as? String ?? ""
        let email = data.object(forKey: "email") as? String ?? ""

        let profilePictureObj = data.object(forKey: "picture") as? NSDictionary
        let data = profilePictureObj?.value(forKey: "data") as? NSDictionary
        let pictureUrlString = data?.value(forKey: "url") as? String
        let pictureUrl = URL(string: pictureUrlString ?? "")

        self.LoginSocial(uid, "F", email ,"" ,pictureUrl , lastName, firstName)
      }
      }
      }
      }
    }
}
