//
//  VerificationVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import FirebaseAuth

class VerificationVC: ViewController {
    
 
    var IsSignUp = Bool()
    var SignUp : SignUpVC?
    var SignIn : SignInVC?
    var VerificationNumber : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        SetUpItems()
    }
    
    fileprivate func SetUpItems() {
        
        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))
        
        view.addSubview(BottomBackgroundImage)
        BottomBackgroundImage.frame = CGRect(x: ControlX(30), y: view.frame.height / 1.5, width: view.frame.width - ControlX(30), height: view.frame.height / 3)
        
        view.addSubview(BottomBarImage)
        self.BottomBarImage.frame = CGRect(x: 0, y: self.view.frame.height - ControlHeight(60), width: self.view.frame.width, height: ControlHeight(60))
        
        view.addSubview(ViewScroll)
        ViewScroll.frame = CGRect(x: ControlX(20), y: LogoImage.frame.maxY + ControlY(30), width: view.frame.width - ControlX(40), height:  view.frame.height / 1.5)
        
        ViewScroll.addSubview(StackItems)
        StackItems.frame = CGRect(x: 0, y: 0, width: ViewScroll.frame.width , height: ViewScroll.frame.height - ControlY(10))

        Number1TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number2TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number3TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number4TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number5TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        Number6TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
               
        StartTimer()
        ViewScroll.updateContentViewSize(0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Number1TF.becomeFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.ViewScroll.setContentOffset(CGPoint(x: 0, y: ControlWidth(140)), animated: true)
        }
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
        
        let attributedString = NSMutableAttributedString(string: "Enter".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Verification Code".localizable.uppercased(), attributes: [
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
    

    lazy var VerificationLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Enter the code sent to".localizable, attributes: [
            .font: UIFont(name: "Poppins-Regular", size: ControlWidth(18)) ?? UIFont.systemFont(ofSize: ControlWidth(18)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        if let PhoneNumber = IsSignUp == true ? SignUp?.PhoneNumberTF.text : SignIn?.PhoneNumberTF.text {
        let Number = "lang".localizable == "ar" ? PhoneNumber.NumAR():PhoneNumber
        attributedString.append(NSAttributedString(string: "\(Number)  ", attributes: [
            .font: UIFont(name: "Poppins-Regular", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) ,
            .paragraphStyle:style
        ]))
        }
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Edit Number".localizable, attributes: [
            .font: UIFont(name: "Poppins-Medium", size: ControlWidth(16)) ?? UIFont.systemFont(ofSize: ControlWidth(16)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.isUserInteractionEnabled = true
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:))))
        return Label
    }()
    
    @objc func tapLabel(_ gesture: UITapGestureRecognizer) {
    guard let text = VerificationLabel.attributedText?.string else {return}

    guard let click_range = text.range(of: "Edit Number".localizable) else {return}
    if VerificationLabel.didTapAttributedTextInLabel(gesture: gesture, inRange: NSRange(click_range, in: text)) {
        
    if IsSignUp == true { SignUp?.PhoneNumberTF.becomeFirstResponder() }
    else{ self.SignIn?.PhoneNumberTF.becomeFirstResponder()}
    self.navigationController?.popViewController(animated: true)
    }
    }
    
    lazy var Number1TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number2TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number3TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number4TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number5TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var Number6TF : FloatingTF = {
        let tf = FloatingTF()
        tf.ShowError = false
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.font = UIFont.systemFont(ofSize: ControlWidth(24))
        return tf
    }()
    
    lazy var StackTF : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [Number1TF,Number2TF,Number3TF,Number4TF,Number5TF,Number6TF])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .fillEqually
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        return Stack
    }()
    
    lazy var ValidateButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Validate".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionValidate), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()
    
    @objc func ActionValidate() {
    if let Number1 = Number1TF.text ,let Number2 = Number2TF.text ,let Number3 = Number3TF.text , let Number4 = Number4TF.text ,let Number5 = Number5TF.text , let Number6 = Number6TF.text {
    let Text = Number1 + Number2 + Number3 + Number4 + Number5 + Number6

    if Text.count != 6 {
    Number1TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number2TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number3TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number4TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number5TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    Number6TF.layer.borderColor = UIColor(red: 239 / 255, green:  156 / 255, blue: 156 / 255, alpha: 1).cgColor
    
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = false
    }
    
    }else{
    Number1TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number2TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number3TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number4TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number5TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
    Number6TF.layer.borderColor = UIColor(red: 229 / 255.0, green: 229 / 255.0, blue: 229 / 255.0, alpha: 1.0).cgColor
        
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
        
    guard let Verification = VerificationNumber else { return }
    VerifyDigitCode(code: Text, vId: Verification)
    }
    }
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
    let text = textField.text
            
    if let t: String = textField.text {
    textField.text = String(t.prefix(1))
    }
        
    if text?.count == 1 {
    switch textField {
    case Number1TF:
    Number2TF.becomeFirstResponder()
    case Number2TF:
        Number3TF.becomeFirstResponder()
    case Number3TF:
        Number4TF.becomeFirstResponder()
    case Number4TF:
        Number5TF.becomeFirstResponder()
    case Number5TF:
        Number6TF.becomeFirstResponder()
    case Number6TF:
        Number6TF.resignFirstResponder()
    default:
    break
    }
    }
    if text?.count == 0 {
    UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
    self.IsnotCorrect.isHidden = true
    }
    switch textField{
    case Number1TF:
        Number1TF.becomeFirstResponder()
    case Number2TF:
        Number1TF.becomeFirstResponder()
    case Number3TF:
        Number2TF.becomeFirstResponder()
    case Number4TF:
        Number3TF.becomeFirstResponder()
    case Number5TF:
        Number4TF.becomeFirstResponder()
    case Number6TF:
        Number5TF.becomeFirstResponder()
    default:
    break
    }
    }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true
    }
    

    lazy var IsnotCorrect : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        Label.isHidden = true
        Label.backgroundColor = .clear
        Label.text = "OTP is not correct".localizable
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Medium" ,size: ControlWidth(15))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(20)).isActive = true
        return Label
    }()

    lazy var Labeltimer : UILabel = {
        let Label = UILabel()
        Label.backgroundColor = .clear
        Label.isUserInteractionEnabled = false
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        Label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LabelTimerAction)))
        return Label
    }()
    
    @objc func LabelTimerAction() {
        StartTimer()
        VerificationSend()
    }

    var timer = Timer()
    var newTimer = 120
    @objc func ActionLabeltimer()  {
    let Timer = "lang".localizable == "ar" ? "\(timeFormatted(newTimer))".NumAR() : "\(timeFormatted(newTimer))"
    newTimer -= 1
    AttributedString(Labeltimer, "The code will be resend in".localizable, Timer, "sec".localizable)
    Labeltimer.isUserInteractionEnabled = false
    if newTimer < -1 {
    let Text = "Resend OTP".localizable
        
    AttributedString(Labeltimer, Text, "", "")
    Labeltimer.isUserInteractionEnabled = true
    timer.invalidate()
    }
    }
    
    
    public func AttributedString(_ Label:UILabel,_ Text1:String,_ Text2:String,_ Text3:String) {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
        
    let underlinedMessage = NSMutableAttributedString(string: Text1 + " ", attributes: [
    .font: UIFont(name: "Poppins-Regular", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
    .paragraphStyle:style,
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ])
    underlinedMessage.append(NSAttributedString(string: Text2 + " ", attributes: [
    .font: UIFont(name: "Poppins-Regular" , size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
    .paragraphStyle:style
    ]))
    
    underlinedMessage.append(NSAttributedString(string: Text3, attributes: [
    .font: UIFont(name: "Poppins-Medium", size: ControlWidth(14)) ?? UIFont.systemFont(ofSize: ControlWidth(14)),
    .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
    .paragraphStyle:style,
    .underlineStyle: NSUnderlineStyle.single.rawValue
    ]))

    Label.attributedText = underlinedMessage
    }
    

    
    func StartTimer() {
    newTimer = 120
    timer = Timer.scheduledTimer(timeInterval: 1 , target: self , selector:  #selector(ActionLabeltimer) , userInfo: nil , repeats:  true)
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func VerificationSend() {
    guard let phone = IsSignUp == true ? SignUp?.PhoneNumberTF.text : SignIn?.PhoneNumberTF.text else {return}
    let phoneNumber = phone
            
    self.ViewDots.beginRefreshing()
    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
    if let error = error {
    self.ViewDots.endRefreshing(error.localizedDescription, .error, {})
    }else{
    guard let verificationID = verificationID else { return }
    self.ViewDots.endRefreshing { }
    self.VerificationNumber = verificationID
    }
    }
    }
    
    
    func VerifyDigitCode(code: String, vId: String) {
    self.ViewDots.beginRefreshing()
    let credential = PhoneAuthProvider.provider().credential(withVerificationID: vId, verificationCode: code)
    Auth.auth().signIn(with: credential) { (result, error) in
    DispatchQueue.main.async {
    if let err = error {
    self.ViewDots.endRefreshing(err.localizedDescription, .error, {})
    return
    }
    guard let Result = result else { return }
    self.CreateAccount(uid:  Result.user.uid, phoneNumber: Result.user.phoneNumber)
    }
    }
    }
    
    func CreateAccount(uid:String,phoneNumber:String?) {
        
    if IsSignUp {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
        
    guard let FirstName = SignUp?.FirstNameTF.text else{return}
    guard let Email = SignUp?.EmailTF.text else{return}
    guard let phone = phoneNumber else{return}
    let LastName = SignUp?.LastNameTF.text ?? ""
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
        
    }else{
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
    SignUp.isValidNumber = true
    SignUp.PhoneNumberTF.text = phoneNumber
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

    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopLabel,VerificationLabel,StackTF,Labeltimer,IsnotCorrect,ValidateButton])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        return Stack
    }()

}
