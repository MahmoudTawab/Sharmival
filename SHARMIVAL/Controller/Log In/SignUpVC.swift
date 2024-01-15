//
//  SignUpVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class SignUpVC: ViewController ,FPNTextFieldDelegate {
    
    var uid : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))
        
        view.addSubview(BottomBackgroundImage)
        BottomBackgroundImage.frame = CGRect(x: ControlX(30), y: view.frame.height / 1.5, width: view.frame.width - ControlX(30), height: view.frame.height / 3)
        
        view.addSubview(BottomBarImage)
        self.BottomBarImage.frame = CGRect(x: 0, y: self.view.frame.height - ControlHeight(60), width: self.view.frame.width, height: ControlHeight(60))

        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: ControlX(20), y: LogoImage.frame.maxY + ControlY(20), width: view.frame.width - ControlX(40), height:  view.frame.height / 1.5)
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: 0, y: 0, width: ViewScroll.frame.width , height:  ViewScroll.frame.height - ControlY(10))
        ViewScroll.updateContentViewSize(0)
        
        SetUpPhoneNumber()
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
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()


    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Sign".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "UP".localizable.uppercased(), attributes: [
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
    
    lazy var FirstNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "First Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var LastNameTF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.TitleHidden = false
        tf.attributedPlaceholder = NSAttributedString(string: "Last Name".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    lazy var StackName : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [FirstNameTF,LastNameTF])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Stack
    }()
    
    lazy var EmailTF : FloatingTF = {
        let tf = FloatingTF()
        tf.Enum = .IsEmail
        tf.TitleHidden = false
        tf.keyboardType = .emailAddress
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Email Address".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    var repository: FPNCountryRepository = FPNCountryRepository()
    lazy var PhoneNumberTF : FPNTextField = {
        let tf = FPNTextField()
        tf.displayMode = .list
        tf.delegate = self
        tf.backgroundColor = #colorLiteral(red: 0.931889832, green: 0.931889832, blue: 0.931889832, alpha: 1)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Phone number".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    
    func SetUpPhoneNumber() {
    listController.setup(repository: PhoneNumberTF.countryRepository)
    listController.didSelect = { [weak self] country in
    self?.PhoneNumberTF.setFlag(countryCode: country.code)
    }
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code)
    }
    
    var isValidNumber = false
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
    isValidNumber = isValid
    }
    
    
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController: listController)
        listController.title = "Select your country".localizable
        listController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCountries))
        listController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCountries))
        listController.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        listController.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        listController.searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listController.searchController.searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        navigationViewController.modalPresentationStyle = .fullScreen
        navigationViewController.modalTransitionStyle = .coverVertical
        present(navigationViewController, animated: true)
    }
    
    @objc func refreshCountries() {
    listController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func dismissCountries() {
    listController.dismiss(animated: true, completion: nil)
    }
    

    
    lazy var SignUp : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Sign up".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSignUp), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSignUp() {
    if isValidNumber && uid != nil {
    SignUpApi()
    }else{
    PresentToVerification()
    }
    }
    
    func PresentToVerification() {
        if FirstNameTF.NoError() && PhoneNumberTF.NoError() && isValidNumber && EmailTF.NoError() && EmailTF.NoErrorEmail() {
        guard let phone = PhoneNumberTF.text?.replacingOccurrences(of: " ", with: "") else {return}
        let phoneNumber = PhoneNumberTF.flag + phone
            
        self.ViewDots.beginRefreshing()
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
        DispatchQueue.main.async {
        if error != nil {
        self.ViewDots.endRefreshing("The phone number should begin with 01".localizable, .error, {})
        return
        }else{
        guard let verificationID = verificationID else { return }
        self.ViewDots.endRefreshing {
        let Verification = VerificationVC()
        Verification.IsSignUp = true
        Verification.SignUp = self
        Verification.VerificationNumber = verificationID
        Present(ViewController: self, ToViewController: Verification)
        }
        }
        }
        }
        }
    }
    
    func SignUpApi() {
        guard let url = defaults.string(forKey: "API") else {return}
        guard let FirstName = FirstNameTF.text else {return}
        guard let phone = PhoneNumberTF.text else {return}
        guard let Email = EmailTF.text else {return}
        guard let uid = uid else {return}

        let LastName = LastNameTF.text ?? ""
        let signUpType = defaults.string(forKey: "signUpType") ?? "E"
            
        let api = "\(url + ApiSignUp)"
        let token = defaults.string(forKey: "jwt") ?? ""
        let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
            
        let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                        "platform": "I",
                                        "deviceID": udid,
                                        "uid": uid,
                                        "fName": FirstName,
                                        "lName": LastName,
                                        "mobile": phone,
                                        "email": Email,
                                        "signUpType": signUpType]

        self.ViewDots.beginRefreshing()
        PostAPI(api: api, token: token, parameters: parameters) { _ in
        } DictionaryData: { data in
        self.ViewDots.endRefreshing {}
        HomeVC.Main = MainScreen(dictionary: data)
        SaveProfile(MainScreen(dictionary: data), uid)
            
        FirstController(TabBarController())
        } ArrayOfDictionary: { _ in
        } Err: { error in
        self.ViewDots.endRefreshing(error, .error, {})
        }
    }

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,StackName,PhoneNumberTF,EmailTF,SignUp])
        Stack.axis = .vertical
        Stack.spacing = ControlX(10)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
}

