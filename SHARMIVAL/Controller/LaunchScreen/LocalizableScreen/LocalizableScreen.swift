//
//  LocalizableScreen.swift
//  SHARMIVAL
//
//  Created by Emojiios on 07/09/2022.
//

import UIKit

class LocalizableScreen: ViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    var lang : String?
    override func viewDidLoad() {
        super.viewDidLoad()
//      GetLanguage()
        SetDataLanguage()
        view.backgroundColor = .white

        view.addSubview(LogoImage)
        LogoImage.frame = CGRect(x: ControlX(65), y: ControlY(60), width: view.frame.width - ControlX(130), height: ControlWidth(28))
        
        view.addSubview(BottomBackgroundImage)
        BottomBackgroundImage.frame = CGRect(x: ControlX(30), y: view.frame.height / 1.5, width: view.frame.width - ControlX(30), height: view.frame.height / 3)
        
        view.addSubview(BottomBarImage)
        BottomBarImage.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 0)

        view.addSubview(TopLabel)
        TopLabel.topAnchor.constraint(equalTo: LogoImage.bottomAnchor,constant: ControlY(30)).isActive = true
        TopLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
        TopLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
        TopLabel.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true

        view.addSubview(LocalizableCollection)
        LocalizableCollection.heightAnchor.constraint(equalToConstant: ControlWidth(300)).isActive = true
        LocalizableCollection.topAnchor.constraint(equalTo: TopLabel.bottomAnchor,constant: ControlY(30)).isActive = true
        LocalizableCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(30)).isActive = true
        LocalizableCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-30)).isActive = true
        
        view.addSubview(LocalizableCenter)
        LocalizableCenter.widthAnchor.constraint(equalToConstant: ControlWidth(130)).isActive = true
        LocalizableCenter.heightAnchor.constraint(equalTo: LocalizableCenter.widthAnchor).isActive = true
        LocalizableCenter.centerYAnchor.constraint(equalTo: LocalizableCollection.centerYAnchor).isActive = true
        LocalizableCenter.centerXAnchor.constraint(equalTo: LocalizableCollection.centerXAnchor).isActive = true
        
        view.addSubview(ButtonLocalizable)
        ButtonLocalizable.heightAnchor.constraint(equalToConstant: ControlWidth(48)).isActive = true
        ButtonLocalizable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(20)).isActive = true
        ButtonLocalizable.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-20)).isActive = true
        ButtonLocalizable.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: ControlY(-90)).isActive = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: []) {
        self.BottomBarImage.frame = CGRect(x: 0, y: self.view.frame.height - ControlHeight(60), width: self.view.frame.width, height:  ControlHeight(60))
        }
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
    
    lazy var TopLabel : UILabel = {
        let Label = UILabel()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = ControlWidth(5)
        style.alignment = .center
        
        let attributedString = NSMutableAttributedString(string: "Choose".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "your preferred".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "\n", attributes: [
            .foregroundColor: UIColor.clear ,
            .paragraphStyle:style
        ]))
        
        attributedString.append(NSAttributedString(string: "Language".localizable.uppercased(), attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1) ,
            .paragraphStyle:style
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    lazy var LocalizableCenter : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.isUserInteractionEnabled = true
        ImageView.layer.cornerRadius = ControlWidth(65)
        ImageView.image = UIImage(named: "Einglish")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ActionLocalizableCenter)))
        return ImageView
    }()
    
    @objc func ActionLocalizableCenter() {
        
        lang = "en"
        LocalizableSelect = nil
        LocalizableCenter.alpha = 1
        LocalizableCollection.reloadData()
    }
    
    let CircleCellID = "CircleCellID"
    var LocalizableSelect : IndexPath?
    var LanguageData = [Language(id: 2, flag: "Arabic", title: "ar"),
                        Language(id: 3, flag: "Français", title: "fr"),
                        Language(id: 9, flag: "Russian", title: "ru"),
                        Language(id: 10,flag: "Spain", title: "es"),
                        Language(id: 11,flag: "Ukraine", title: "uk"),
                        Language(id: 12,flag: "Italy", title: "it")]
    
//    var LanguageDataCollection = [Language]()
//    var LanguageData = Language(dictionary: [String : Any]())
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
    cell.ImageView.alpha = LocalizableSelect?.item != indexPath.item ? 0.5:1
        
    //    if let url = URL(string: LanguageDataCollection[indexPath.item].flag ?? "") {
    //    let svgView = UIView(svgURL: url) { (svgLayer) in
    //    svgLayer.resizeToFit(cell.ImageView.bounds)}
    //    cell.ImageView.addSubview(svgView)
    //    }
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        LocalizableCenter.alpha = 0.5
        LocalizableSelect = indexPath
        LocalizableCollection.reloadData()
        lang = LanguageData[indexPath.item].title
    }
    
    lazy var ButtonLocalizable : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.Radius = false
        Button.backgroundColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        Button.setTitleColor(.white, for: .normal)
        Button.setTitle("Let’s start".localizable, for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(ActionLocalizable), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "Poppins-Medium", size: ControlWidth(18))
        return Button
    }()

    @objc func ActionLocalizable() {
    if lang != "lang".localizable {
    UpdateDataSetting()
    }else{
    FirstController(ScreenPageView())
    }
    }
    
    func UpdateDataSetting() {
    guard let url = defaults.string(forKey: "API") else {
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
            
    let api = "\(url + UpdateLanguage)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""

    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "Platform": "I",
                                    "deviceID": udid,
                                    "lang": lang ?? "en"]

    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    self.SetLanguage()
    self.ViewDots.endRefreshing {}
    } DictionaryData: { _ in
    } ArrayOfDictionary: { _ in
    } Err: { error in
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
    
    
    func SetDataLanguage() {
        if "lang".localizable == "en" {
        lang = "en"
        LocalizableSelect = nil
        LocalizableCenter.alpha = 1
        LocalizableCollection.reloadData()
        }else{
        if let Language = LanguageData.firstIndex(where: {$0.title == "lang".localizable}) {
        LocalizableCenter.alpha = 0.5
        lang = LanguageData[Language].title
        LocalizableSelect = IndexPath(item: Language, section: 0)
        LocalizableCollection.reloadData()
        }
        }
    }

    
//    @objc func GetLanguage() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    self.ViewDots.endRefreshing {}
//    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let api = "\(url + ApiGetLanguage)"
//
//    let Token = defaults.string(forKey: "jwt") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//
//    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
//                                    "Platform": "I",
//                                    "deviceID": udid]
//
//    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: Token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
//    self.AddData(data)
//    } Err: { error in
//    self.IfNoData(Data:false)
//    self.SetUpIsError(error, true) {
//    self.GetLanguage()
//    }
//    }
//    }
//
//    func AddData(_ array:[[String:Any]]) {
//    LanguageData = Language(dictionary: array.first ?? [String:Any]())
//    for item in array.dropFirst() {
//    LanguageDataCollection.append(Language(dictionary: item))
//    if LanguageDataCollection.count + 1 == array.count {
//    self.IfNoData(Data:true)
//    }
//    }
//    }
//
//    func IfNoData(Data:Bool) {
//    ViewNoData.isHidden = Data
//    self.ViewDots.endRefreshing {}
//    LocalizableCollection.reloadData()
//    LocalizableCenter.isHidden = !Data
//    LocalizableCollection.isHidden = !Data
//    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetLanguage), for: .touchUpInside)
//
//    guard let url = URL(string: LanguageData.flag ?? "") else {return}
//    let svgView = UIView(svgURL: url) { (svgLayer) in
//    svgLayer.resizeToFit(self.LocalizableCenter.bounds)}
//    self.LocalizableCenter.addSubview(svgView)
//    }
}

