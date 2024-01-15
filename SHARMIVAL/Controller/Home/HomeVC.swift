//
//  HomeVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import SDWebImage

struct StructTime {
    var Days: String = "00"
    var Hour: String = "00"
    var Mins: String = "00"
}

class HomeVC: ViewController , SplitflapDataSource, SplitflapDelegate {

    var timer = Timer()
    static var Main:MainScreen?
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMain()
        SetUpItem()
        SetUpTopBarImage()
        view.backgroundColor = .white        
    }
    
    fileprivate func SetUpItem() {
        view.addSubview(ViewScroll)
        ViewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ViewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ViewScroll.topAnchor.constraint(equalTo: view.topAnchor,constant: ControlHeight(60)).isActive = true
        ViewScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: ControlHeight(-50)).isActive = true
        
        ViewScroll.addSubview(StackItem)
        StackItem.topAnchor.constraint(equalTo: ViewScroll.topAnchor,constant: ControlY(5)).isActive = true
        StackItem.bottomAnchor.constraint(equalTo: ViewScroll.bottomAnchor,constant: ControlY(-5)).isActive = true
        StackItem.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        StackItem.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: ControlX(-15)).isActive = true
    
        AddRefreshControl(Scroll: ViewScroll, color: #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)) {
        self.GetMain(Refresh: true)
        }
    }
    
    lazy var WelcomeLabel : UILabel = {
        let Label = UILabel()
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Label
    }()
    

    func SetTextWelcome() {

        let attributedString = NSMutableAttributedString(string: "Welcome to".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: HomeVC.Main?.carnavalName ?? "SHARMIVAL".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        WelcomeLabel.numberOfLines = 0
        WelcomeLabel.backgroundColor = .clear
        WelcomeLabel.attributedText = attributedString
    }
    
    
    // MARK: - SetUp Time Splitflap
    lazy var DaysPlitflap : Splitflap = {
        let View = Splitflap()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var DaysLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Days".localizable.uppercased()
        Label.font = UIFont(name: "CocoGothic-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var BreaksLabel1 : UILabel = {
        let Label = UILabel()
        Label.text = ":"
        Label.textColor = #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont.systemFont(ofSize: ControlWidth(40))
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        return Label
    }()
    
    lazy var HourPlitflap : Splitflap = {
        let View = Splitflap()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var HourLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Hours".localizable.uppercased()
        Label.font = UIFont(name: "CocoGothic-Bold", size: ControlWidth(16))
        return Label
    }()
    
    lazy var BreaksLabel2 : UILabel = {
        let Label = UILabel()
        Label.text = ":"
        Label.textColor = #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont.systemFont(ofSize: ControlWidth(40))
        Label.widthAnchor.constraint(equalToConstant: ControlWidth(10)).isActive = true
        return Label
    }()
    
    lazy var MinsPlitflap : Splitflap = {
        let View = Splitflap()
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()
    
    lazy var MinsLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)
        Label.textAlignment = .center
        Label.backgroundColor = .clear
        Label.text = "Mins".localizable.uppercased()
        Label.font = UIFont(name: "CocoGothic-Bold", size: ControlWidth(16))
        return Label
    }()
    
    func SetUpPlitflap() {
        DaysPlitflap.datasource = self
        DaysPlitflap.delegate   = self
          
        HourPlitflap.datasource = self
        HourPlitflap.delegate   = self
          
        MinsPlitflap.datasource = self
        MinsPlitflap.delegate   = self
          
        DaysPlitflap.reload()
        HourPlitflap.reload()
        MinsPlitflap.reload()
        
        SplitflapText()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(SplitflapText), userInfo: nil, repeats: true)
    }
    
    func numberOfFlapsInSplitflap(_ splitflap: Splitflap) -> Int {
        return 1
    }

    func tokensInSplitflap(_ splitflap: Splitflap) -> [String] {
        if splitflap == DaysPlitflap {
        return SplitflapTokens.Numeric
        }else if splitflap == HourPlitflap {
        return SplitflapTokens.TwentyFourHourClock
        }else {
        return SplitflapTokens.MinuteAndSecond
        }
    }
    
    func splitflap(_ splitflap: Splitflap, rotationDurationForFlapAtIndex index: Int) -> Double {
      return 0.6
      }

    func splitflap(_ splitflap: Splitflap, builderForFlapAtIndex index: Int) -> FlapViewBuilder {
          return FlapViewBuilder { builder in
          builder.backgroundColor = #colorLiteral(red: 0.9043522477, green: 0.9043522477, blue: 0.9043522477, alpha: 1)
          builder.cornerRadius    = ControlX(8)
          builder.textAlignment   = .center
          builder.textColor       = #colorLiteral(red: 0.07645239681, green: 0.3817951083, blue: 0.5639768839, alpha: 1)
          builder.lineColor       = .clear
          builder.font            = UIFont(name: "Gotham-Bold", size: ControlWidth(40))
          }
    }
      

      @objc func SplitflapText() {
      let Days = timeGapBetweenDates(Date().Formatter("yyyy-MM-dd'T'hh:mm:ss a") ,"2024-05-05T10:10:30 am","yyyy-MM-dd'T'hh:mm:ss a")
          
          
      let Mins = "lang".localizable == "ar" ? Days.Mins.NumAR() : Days.Mins
      let Hour = "lang".localizable == "ar" ? Days.Hour.NumAR() : Days.Hour
      let Day = "lang".localizable == "ar" ? Days.Days.NumAR() : Days.Days
          
      if MinsPlitflap.text != Days.Mins {
        MinsPlitflap.setText(Mins, animated: false)
      }
          
      if HourPlitflap.text != Days.Hour {
        HourPlitflap.setText(Hour, animated: false)
      }
          
      if DaysPlitflap.text != Days.Days {
        DaysPlitflap.setText(Day, animated: false)
      }
          
      if Days.Days == "0" && Days.Hour == "0" && Days.Mins == "0" {
      self.timer.invalidate()
      }
      }

      func timeGapBetweenDates(_ previousDate : String,_ currentDate : String,_ fmt:String) -> StructTime {
          
        let Dateformatter = DateFormatter()
        Dateformatter.dateFormat = fmt
        Dateformatter.locale = Locale(identifier: "en")

        let date1 = Dateformatter.date(from: previousDate) ?? Date()
        let date2 = Dateformatter.date(from: currentDate) ?? Date()
          
        let distanceBetweenDates: TimeInterval = date2.timeIntervalSince(date1)
        let days = Int(distanceBetweenDates / 86400)
        let Hour = Int(distanceBetweenDates / 3600)-Int(days*24)
        let Min = Int(distanceBetweenDates / 60)-Int(Hour*60)-Int(days*24*60)
                        
        return StructTime(Days: String(format:"%02d", days), Hour: String(format:"%02d", Hour), Mins: String(format:"%02d", Min))
      }

    lazy var StackTime : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DaysPlitflap,BreaksLabel1,HourPlitflap,BreaksLabel2,MinsPlitflap])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = 0
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false

        Stack.arrangedSubviews[0].widthAnchor.constraint(equalTo: Stack.widthAnchor, multiplier: 1/3.3).isActive = true
        Stack.arrangedSubviews[2].widthAnchor.constraint(equalTo: Stack.arrangedSubviews[0].widthAnchor).isActive = true
        Stack.arrangedSubviews[4].widthAnchor.constraint(equalTo: Stack.arrangedSubviews[0].widthAnchor).isActive = true
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        return Stack
    }()

    lazy var StackTimeLabel : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DaysLabel,HourLabel,MinsLabel])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.backgroundColor = .clear
        Stack.spacing = ControlWidth(10)
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Stack
    }()
    
    // MARK: - End Time Splitflap
    
    lazy var MarkYouLabel : UILabel = {
        let Label = UILabel()
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    
    func SetTextMarkYou() {

        let attributedString = NSMutableAttributedString(string: "Mark your Calendar for Nov".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Regular", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        if let startDate = HomeVC.Main?.startDate?.Formatter(Format: "yyyy-MM-dd") , let endDate = HomeVC.Main?.endDate?.Formatter(Format: "yyyy-MM-dd") {
            attributedString.append(NSAttributedString(string:  "\(startDate.Formatter("dd")) - \(endDate.Formatter("dd"))" , attributes: [
            .font: UIFont(name: "CocoGothic-Medium", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        }
        
        MarkYouLabel.numberOfLines = 0
        MarkYouLabel.backgroundColor = .clear
        MarkYouLabel.attributedText = attributedString
    }
    
    
    lazy var DescriptionLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        Label.numberOfLines = 0
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Regular", size: ControlWidth(16))
        return Label
    }()
    

    // MARK: - SetUp Event CollectionView
    lazy var EventTitle : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Our".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string:  "Events".localizable , attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        return Label
    }()


    lazy var EventViewAll : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("View all".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionEventViewAll), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size:  ControlWidth(18))
        Button.setTitleColor(#colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionEventViewAll() {
    self.tabBarController?.selectedIndex = 2
    }
    
    lazy var EventStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [EventTitle,EventViewAll])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Stack
    }()
        
    let EventId = "Event"
    var itemWidth = CGFloat(0)
    let collectionMargin = CGFloat(0)
    let itemSpacing = ControlWidth(8)
    let itemHeight = ControlWidth(215)
    lazy var EventCV  : UICollectionView = {
        let layout: UICollectionViewFlowLayout = PagingCollectionViewLayout()
        
        itemWidth = (UIScreen.main.bounds.width - ControlWidth(30)) - (collectionMargin + 10) * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.delegate = self
        vc.dataSource = self
        vc.backgroundColor = .clear
        vc.collectionViewLayout = layout
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.decelerationRate = UIScrollView.DecelerationRate.fast
        vc.register(EventAndGalleryCell.self, forCellWithReuseIdentifier: EventId)
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(220)).isActive = true
        return vc
    }()
    

    // MARK: - SetUp Gallery CollectionView
    lazy var GalleryTitle : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "photo".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string:  "Gallery".localizable , attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        Label.numberOfLines = 0
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        return Label
    }()


    lazy var GalleryViewAll : UIButton = {
        let Button = UIButton(type: .system)
        Button.backgroundColor = .clear
        Button.setTitle("View all".localizable, for: .normal)
        Button.addTarget(self, action: #selector(ActionGalleryViewAll), for: .touchUpInside)
        Button.titleLabel?.font = UIFont(name: "CocoGothic-Bold", size:  ControlWidth(18))
        Button.setTitleColor(#colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), for: .normal)
        return Button
    }()
    
    @objc func ActionGalleryViewAll() {
    Present(ViewController: self, ToViewController: AllGalleryVC())
    }
    
    lazy var GalleryStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [GalleryTitle,GalleryViewAll])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = ControlX(10)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Stack
    }()
        
    let GalleryId = "Gallery"
    lazy var GalleryCV  : UICollectionView = {
        let layout: UICollectionViewFlowLayout = PagingCollectionViewLayout()
        
        itemWidth = (UIScreen.main.bounds.width - ControlWidth(30)) - (collectionMargin + 10) * 2.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.headerReferenceSize = CGSize(width: collectionMargin, height: 0)
        layout.footerReferenceSize = CGSize(width: collectionMargin, height: 0)
        
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .horizontal
        
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.delegate = self
        vc.dataSource = self
        vc.backgroundColor = .clear
        vc.collectionViewLayout = layout
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.decelerationRate = UIScrollView.DecelerationRate.fast
        vc.register(EventAndGalleryCell.self, forCellWithReuseIdentifier: GalleryId)
        vc.heightAnchor.constraint(equalToConstant: ControlWidth(220)).isActive = true
        return vc
    }()
    
    lazy var StackItem : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopView,WelcomeLabel,StackTime,StackTimeLabel,MarkYouLabel,DescriptionLabel,EventStack,EventCV,GalleryStack,GalleryCV])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(15)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.isHidden = true
        Scroll.backgroundColor = .clear
        Scroll.translatesAutoresizingMaskIntoConstraints = false
        return Scroll
    }()
    
    @objc func GetMain(Refresh:Bool = false) {
    if HomeVC.Main == nil || Refresh {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let token = defaults.string(forKey: "jwt") ?? ""
    let api = "\(url + GetMainScreen)"
        
    let sqlId = defaults.string(forKey: "sqlId") ?? GUID
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "platform": "I",
                                   "deviceID": udid,
                                   "sqlid": sqlId]
        
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    if Refresh {
    HomeVC.Main = nil
    self.AddData(data)
    }else{
    self.AddData(data)
    }
    
    } ArrayOfDictionary: { _ in
    } Err: { error in
    self.IfNoData(Data:false)
    self.SetUpIsError(error, true) {
    self.GetMain(Refresh:Refresh)}
    }
    }else{
    self.SetUpData()
    self.IfNoData(Data:true)
    }
    }
    
    func AddData(_ array:[String:Any]) {
        HomeVC.Main = MainScreen(dictionary: array)
        SaveProfile(MainScreen(dictionary: array), defaults.string(forKey: "uid") ?? "")

        SetUpData()
        self.IfNoData(Data:true)
    }
    
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    ViewScroll.isHidden = !Data
    self.ViewDots.endRefreshing {}
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetMain), for: .touchUpInside)
        
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
    self.SetUpButton()
    }
    }
    
    func SetUpData() {
        SetUpPlitflap()
        SetTextMarkYou()
        SetTextWelcome()
        EventCV.reloadData()
        GalleryCV.reloadData()
        
        if let Description = HomeVC.Main?.carnavalDescription {
        DescriptionLabel.text = Description
        DescriptionLabel.addInterlineSpacing(spacingValue: ControlX(3))
        }
        
        ViewScroll.updateContentViewSize(ControlX(30))
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == EventCV {
        return 10
//            HomeVC.Main?.events.count ?? 0
        }else{
        return HomeVC.Main?.gallery.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == EventCV {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventId,for: indexPath) as! EventAndGalleryCell
        cell.backgroundColor = .clear
//        if let events = HomeVC.Main?.events {
        cell.DateLabel.text = "2024-05-05 10:00 am"
//            events[indexPath.item].date ?? ""
        cell.EventName.text = "Events Name"
//            "\(events[indexPath.item].fName ?? "") \(events[indexPath.item].lName ?? "")"
//            URL(string: events[indexPath.item].image
        cell.Image.sd_setImage(with: URL(string: "https://cdn0-production-images-kly.akamaized.net/xYEcqMdBWw6pN0mFBFD5_5uIjz8=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3396365/original/023706600_1615209973-concert-768722_1280.jpg"), placeholderImage: UIImage(named: "Group 26056"))
//        }
        return cell
        }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryId,for: indexPath) as! EventAndGalleryCell
        cell.backgroundColor = .clear
        if let gallery = HomeVC.Main?.gallery {
        cell.DateLabel.text = ""
        cell.EventName.text = "\(gallery[indexPath.item].name ?? "")"
        cell.Image.sd_setImage(with: URL(string: gallery[indexPath.item].image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        }
        return cell
        }
    }

 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == EventCV {
//        if let events = HomeVC.Main?.events {
        let DayEvents = DayEventsVC()
        DayEvents.dayId = "1"
//            events[indexPath.item].dayId
        DayEvents.ViewDismiss.TextLabel = "Events Name"
//            "\(events[indexPath.item].fName ?? "")"
        Present(ViewController: self, ToViewController: DayEvents)
//        }
        }else{
        if let gallery = HomeVC.Main?.gallery {
        let Gallery = SingleGalleryVC()
        Gallery.Id = gallery[indexPath.item].id ?? ""
        Gallery.Header = gallery[indexPath.item].name ?? ""
        Present(ViewController: self, ToViewController: Gallery)
        }
        }
    }
}


