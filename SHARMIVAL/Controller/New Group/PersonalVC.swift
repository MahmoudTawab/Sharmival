//
//  PersonalVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 12/09/2022.
//

import UIKit
import SDWebImage

class PersonalVC: ViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItem()
        view.backgroundColor = .white
    }
    
    fileprivate func SetUpItem() {
    GetProfileData()
    SetUpTopBarImage(100)
    TopBarImage.transform = .identity
    TopBarImage.image = UIImage(named: "Mask Group 48")
        
    view.addSubview(BottomBackgroundImage)
    BottomBackgroundImage.frame = CGRect(x: ControlX(30), y: view.frame.height / 1.5, width: view.frame.width - ControlX(30), height: view.frame.height / 3)
        
    view.addSubview(ProfileStack)
    ProfileStack.frame = CGRect(x: ControlWidth(50), y: TopBarImage.frame.maxY + ControlY(50), width: view.frame.width - ControlWidth(100), height:  ControlWidth(155))

    view.addSubview(ViewScroll)
    ViewScroll.frame = CGRect(x: ControlX(15), y: ProfileStack.frame.maxY + ControlY(30), width: view.frame.width - ControlX(30), height:  view.frame.height / 1.8)
        
    ViewScroll.addSubview(StackItems)
    StackItems.frame = CGRect(x: 0, y: ControlY(30), width: ViewScroll.frame.width , height:  ViewScroll.frame.height - ControlY(40))
    ViewScroll.updateContentViewSize(0)
        
    view.addSubview(ViewDismiss)
    ViewDismiss.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
    ViewDismiss.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
    ViewDismiss.widthAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
    ViewDismiss.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
    view.addSubview(EditImage)
    EditImage.widthAnchor.constraint(equalTo: EditImage.heightAnchor).isActive = true
    EditImage.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
    EditImage.bottomAnchor.constraint(equalTo: ProfileStack.arrangedSubviews[0].bottomAnchor).isActive = true
    EditImage.rightAnchor.constraint(equalTo: ProfileStack.arrangedSubviews[0].rightAnchor).isActive = true
    }
    
    lazy var BottomBackgroundImage:UIImageView = {
        let Image = UIImageView()
        Image.backgroundColor = .clear
        Image.image = UIImage(named: "Mask Group 46")
        return Image
    }()
    
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
    
    lazy var ProfileImage : ImageAddBorder = {
        let ImageView = ImageAddBorder()
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(50)
        ImageView.Image.image = UIImage(named: "Profile")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.heightAnchor.constraint(equalTo: ImageView.widthAnchor).isActive = true
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(100)).isActive = true
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionImage)))
        ImageView.AddBorder(Color: .white, width: 3)
        return ImageView
    }()
    
    @objc func ActionImage() {
    if let imageUrl = URL(string: self.ProfileData?.image ?? "") {
    let datasource = FMImageDataSource(imageURLs: [imageUrl])
    let config = Config(initImageView: ProfileImage.Image, initIndex: 0)
    let fmImageVC = FMImageSlideViewController(datasource: datasource, config: config)
    fmImageVC.view.frame = ProfileImage.frame
    self.present(fmImageVC, animated: true)
    }
    }
    
    lazy var EditImage : UIButton = {
        let Button = UIButton(type: .system)
        Button.isHidden = true
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Edit"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionEditImage), for: .touchUpInside)
        return Button
    }()
    
    @objc func ActionEditImage() {
    let ImagePickerController = UIImagePickerController()
    ImagePickerController.allowsEditing = true
    ImagePickerController.delegate = self
    let Style = UIDevice.current.userInterfaceIdiom == .phone ? UIAlertController.Style.actionSheet:UIAlertController.Style.alert
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: Style)
        alertController.addAction(UIAlertAction(title: "Camera".localizable, style: .default, handler: { (action:UIAlertAction) in
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
    ImagePickerController.sourceType = .camera
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }else{print("Camera not available")}
    }))
    alertController.addAction(UIAlertAction(title: "Photo Library".localizable, style: .default, handler: { (action:UIAlertAction) in
    ImagePickerController.sourceType = .photoLibrary
    ImagePickerController.modalPresentationStyle = .fullScreen
    self.present(ImagePickerController, animated: true , completion: nil)
    }))

    alertController.addAction(UIAlertAction(title: "Cancel".localizable, style: .default, handler: { (action:UIAlertAction) in
    alertController.dismiss(animated: true)
    }))
    
    alertController.modalPresentationStyle = .fullScreen
    self.present(alertController, animated: true , completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
        ProfileSaveChanges(image)
        ProfileImage.Image.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
    }
    

    func ProfileSaveChanges(_ image:UIImage) {
    guard let uid = defaults.string(forKey: "uid") else { return }
    ViewDots.beginRefreshing()
    Storag(child1: uid, child2: "UserProfile" , image: image) { String in
    self.UpdateImage(imageUrl:String)
    } Err: { Error in
    self.ViewDots.endRefreshing {
    ShowMessageAlert("ErrorIcon", "Error".localizable , "Update image Error".localizable, false, {})
    }
    }
    }
    
    func UpdateImage(imageUrl:String) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + UpdateImageProfile)"
    let uid = defaults.string(forKey: "uid") ?? ""
    let Token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? GUID
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "sqlId": sqlId,
                                    "uId": uid,
                                    "image": imageUrl]
            
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: Token, parameters: parameters) { _ in
    self.ViewDots.endRefreshing("The image has been successfully updated".localizable, .success) {}
    defaults.set(imageUrl, forKey: "profileImage")
    defaults.synchronize()
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    
    lazy var NameLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "CocoGothic-Bold" ,size: ControlWidth(24))
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return Label
    }()

    lazy var ProfileStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [ProfileImage,NameLabel])
        Stack.isHidden = true
        Stack.spacing = ControlX(5)
        Stack.axis = .vertical
        Stack.alignment = .center
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
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
    
    lazy var PhoneNumberTF : FloatingTF = {
        let tf = FloatingTF()
        tf.alpha = 0.6
        tf.isEnabled = false
        tf.TitleHidden = false
        tf.backgroundColor = #colorLiteral(red: 0.931889832, green: 0.931889832, blue: 0.931889832, alpha: 1)
        tf.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        tf.attributedPlaceholder = NSAttributedString(string: "Phone number".localizable, attributes:[.foregroundColor: #colorLiteral(red: 0.3867337108, green: 0.3412475586, blue: 0.3196612, alpha: 0.7965842526)])
        return tf
    }()
    
    
    lazy var SaveButton : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Save".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionSave), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        Button.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        return Button
    }()

    @objc func ActionSave() {
    if FirstNameTF.NoError() && EmailTF.NoError() && EmailTF.NoErrorEmail() {
    if IfChanges() == false {
    self.navigationController?.popViewController(animated: true)
    }else{
    ProfileUpdate()
    }
    }
    }
    
    func IfChanges() -> Bool {
    if let Profile = ProfileData {
    if FirstNameTF.text == Profile.fName &&
    EmailTF.text == Profile.email &&
    LastNameTF.text == Profile.lName {
    return false
    }else{
    return true
    }
    }else{
    return false
    }
    }
    

    func ProfileUpdate() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    guard let fName = FirstNameTF.text else{return}
    guard let Email = EmailTF.text else{return}

    let lName = LastNameTF.text ?? ""
    let api = "\(url + ApiUpdateProfile)"
    let uid = defaults.string(forKey: "uid") ?? ""
    let Token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? GUID
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "sqlId": sqlId,
                                    "uId": uid,
                                    "fName": fName,
                                    "lName": lName,
                                    "email": Email]
            
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: Token, parameters: parameters) { _ in
    self.NameLabel.text = "\(fName) \(lName)".uppercased()
    self.ViewDots.endRefreshing("Your personal data has been updated successfully".localizable, .success) {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.ViewDots.endRefreshing(error, .error) {}
    }
    }
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.isHidden = true
        Scroll.backgroundColor = .clear
        Scroll.keyboardDismissMode = .interactive
        Scroll.showsVerticalScrollIndicator = false
        return Scroll
    }()
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [StackName,PhoneNumberTF,EmailTF,SaveButton])
        Stack.axis = .vertical
        Stack.clipsToBounds = false
        Stack.spacing = ControlX(10)
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        return Stack
    }()
    
    var ProfileData:Profile?
    @objc func GetProfileData() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let api = "\(url + GetProfile)"

    let Token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? GUID
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "sqlId": sqlId]
        
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: Token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.AddData(data)
    } ArrayOfDictionary: { _ in
    }Err: { error in
    self.IfNoData(Data:false)
    self.SetUpIsError(error, true) {
    self.GetProfileData()}
    }
    }
        
    func AddData(_ array:[String:Any]) {
    self.ProfileData = Profile(dictionary: array)
    if let image = self.ProfileData?.image {
    ProfileImage.Image.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "Profile"))
    }
       
    self.IfNoData(Data:true)
    FirstNameTF.text = self.ProfileData?.fName ?? ""
    LastNameTF.text = self.ProfileData?.lName ?? ""
    EmailTF.text = self.ProfileData?.email ?? ""
    PhoneNumberTF.text = self.ProfileData?.mobile ?? ""
    NameLabel.text = "\(self.ProfileData?.fName ?? "") \(self.ProfileData?.lName ?? "")".uppercased()
    }
        
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    ViewScroll.isHidden = !Data
    ProfileStack.isHidden = !Data
    EditImage.isHidden = !Data
    self.ViewDots.endRefreshing {}
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetProfileData), for: .touchUpInside)
    }
}


