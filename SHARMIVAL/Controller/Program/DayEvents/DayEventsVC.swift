//
//  DayEventsVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit
import SDWebImage

class DayEventsVC: ViewController ,EvintViewDelegate {

    var IsFav = false
    var dayId : String?
    var EventsDays : DayEvents?
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        GetEventsDay()
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
        
        view.addSubview(TopViewDate)
        TopViewDate.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TopViewDate.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TopViewDate.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        TopViewDate.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor,constant: ControlY(10)).isActive = true
        
        TopViewDate.addSubview(TopStack)
        TopStack.topAnchor.constraint(equalTo: TopViewDate.topAnchor, constant: ControlX(10)).isActive = true
        TopStack.bottomAnchor.constraint(equalTo: TopViewDate.bottomAnchor, constant: ControlX(-10)).isActive = true
        TopStack.leadingAnchor.constraint(equalTo: TopViewDate.leadingAnchor, constant: ControlX(15)).isActive = true
        TopStack.trailingAnchor.constraint(equalTo: TopViewDate.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(ViewScroll)
        ViewScroll.topAnchor.constraint(equalTo: TopViewDate.bottomAnchor,constant: ControlY(10)).isActive = true
        ViewScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        ViewScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ViewScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        ViewScroll.addSubview(HourView)
        HourView.topAnchor.constraint(equalTo: ViewScroll.topAnchor,constant: ControlX(10)).isActive = true
        HourView.heightAnchor.constraint(equalToConstant: ControlWidth(60)).isActive = true
        HourView.leadingAnchor.constraint(equalTo: ViewScroll.leadingAnchor).isActive = true
        HourView.trailingAnchor.constraint(equalTo: ViewScroll.trailingAnchor).isActive = true
            
        ViewScroll.addSubview(TimeScroll)
        TimeScroll.leadingAnchor.constraint(equalTo: ViewScroll.leadingAnchor).isActive = true
        TimeScroll.trailingAnchor.constraint(equalTo: ViewScroll.trailingAnchor).isActive = true
        TimeScroll.topAnchor.constraint(equalTo: HourView.bottomAnchor,constant: ControlX(30)).isActive = true
        TimeScroll.bottomAnchor.constraint(equalTo:  view.bottomAnchor).isActive = true
    }
        
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
    
    
    // MARK: - Date View Top
    
    var isNext : String?
    var isPrevious : String?
    lazy var NextDay : ButtonNotEnabled = {
        let Button = ButtonNotEnabled(type: .system)
        Button.tintColor = .white
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Path"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        Button.addTarget(self, action: #selector(ActionNextDay), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Button
    }()
    
    var TestdayIndex = 1
    @objc func ActionNextDay() {
//        let dayIndex = (EventsDays?.dayIndex ?? 0) - 1
//        if dayIndex < (EventsDays?.Days.count ?? 0) - 1 {
//        if let Id = EventsDays?.Days[dayIndex + 1].dayId {
//        dayId = Id
//        GetEventsDay()
//        }
//        }else{
//        YesterDay.Shake()
//        }
        
        if TestdayIndex < 2 {
        TestdayIndex += 1
        GetEventsDay()
        }else{
        YesterDay.Shake()
        }
    }
    
    lazy var LabelDay : UILabel = {
        let Label = UILabel()
        Label.textColor = .white
        Label.backgroundColor = .clear
        Label.font = UIFont(name: "Poppins-Medium" ,size: ControlWidth(16))
        return Label
    }()
    
    lazy var YesterDay : ButtonNotEnabled = {
        let Button = ButtonNotEnabled()
        Button.tintColor = .white
        Button.backgroundColor = .clear
        Button.setImage(UIImage(named: "Path"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.transform = CGAffineTransform(rotationAngle: (.pi / 2))
        Button.addTarget(self, action: #selector(ActionYesterDay), for: .touchUpInside)
        Button.widthAnchor.constraint(equalToConstant: ControlWidth(25)).isActive = true
        return Button
    }()
    
    
    @objc func ActionYesterDay() {
//    let dayIndex = (EventsDays?.dayIndex ?? 0) - 1
//    if dayIndex > 0 {
//    if let Id = EventsDays?.Days[dayIndex - 1].dayId {
//    dayId = Id
//    GetEventsDay()
//    }
//    }else{
//    NextDay.Shake()
//    }
        
        if TestdayIndex > 1 {
        TestdayIndex -= 1
        GetEventsDay()
        }else{
        YesterDay.Shake()
        }
    }

    
    lazy var DateStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [YesterDay,LabelDay,NextDay])
        Stack.alignment = .fill
        Stack.axis = .horizontal
        Stack.spacing = ControlX(2)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.widthAnchor.constraint(equalToConstant: view.frame.width / 1.7).isActive = true
        return Stack
    }()
    
    lazy var ViewSpacing : UIView = {
        let View = UIView()
        View.backgroundColor = .white
        View.translatesAutoresizingMaskIntoConstraints = false
        View.widthAnchor.constraint(equalToConstant: ControlWidth(1.5)).isActive = true
        return View
    }()
    

    lazy var ShowFav : ButtonNotEnabled = {
        let Button = ButtonNotEnabled()
        Button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Button.backgroundColor = .clear
        Button.setTitleColor(UIColor.white, for: .normal)
        Button.semanticContentAttribute = .forceLeftToRight
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.setTitle("   " + "Show Fav".localizable , for: .normal)
        Button.setImage(UIImage(named: "heart-circle"), for: .normal)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(18))
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.addTarget(self, action: #selector(ActionShowFav), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: ControlY(4), right: 0)
        return Button
    }()

    @objc func ActionShowFav() {
    IsFav = !IsFav
    self.ViewDots.beginRefreshing()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {self.ViewDots.endRefreshing {}}
    ShowFav.setImage(IsFav ?  UIImage(named: "HeartEnabled") : UIImage(named: "heart-circle") , for: .normal)
    SetUpEvents()
    }
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [DateStack,ViewSpacing,ShowFav])
        Stack.spacing = 0
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var TopViewDate : UIView = {
        let View = UIView()
        View.isHidden = true
        View.backgroundColor = #colorLiteral(red: 0.6131899357, green: 0.8091540337, blue: 0.6118457913, alpha: 1)
        View.translatesAutoresizingMaskIntoConstraints = false
        return View
    }()

    lazy var ViewScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.backgroundColor = .clear
        Scroll.translatesAutoresizingMaskIntoConstraints = false
        return Scroll
    }()
    
    lazy var TimeScroll : UIScrollView = {
        let Scroll = UIScrollView()
        Scroll.bounces = false
        Scroll.clipsToBounds = true
        Scroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Scroll.showsVerticalScrollIndicator = false
        Scroll.translatesAutoresizingMaskIntoConstraints = false
        return Scroll
    }()
    
    lazy var HourView : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [])
        Stack.axis = .horizontal
        Stack.alignment = .fill
        Stack.spacing = 0
        Stack.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        Stack.distribution = .fillEqually
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()


    @objc func GetEventsDay() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    self.ViewDots.endRefreshing {}
//    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + GetDayEvents)"
//    
//    let sqlId = defaults.string(forKey: "sqlId") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
//                                    "platform": "I",
//                                    "deviceID": udid,
//                                    "dayId": dayId ?? GUID,
//                                    "sqlId": sqlId]
//            
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { data in
        
        var data = [String : Any]()
        
        if TestdayIndex == 1 {
        data = [
                "id" : "",
                "fName" : "Events Name",
                "lName" : "",
                "date" : "2024-05-05",
                "dayIndex" : 1,
                
                "barUnitWidth" : 1,
                "firstDate" : "2024-05-05T01:00:00",
                "lastDate" : "2024-05-05T05:00:00",
                "hasNewNotifications" : true,
                
                "rows" : [
                    ["rowIndex" : 1
                     ,"events" : [
                        ["scheduleId" : "",
                         "marginLeft" : 0,
                         "width" : 480,
                         "time" : "01:00-03:00",
                         "fName" : "Events Name",
                         "lName" : "",
                         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6GMm82ctxHQHkbdTQOQ_m3mH_GaT7ZqQIsOKThsgj0mAZPBFbSTNdKut2guC3ZHs-tcc&usqp=CAU",
                         "isFav" : false ],
                        
                        ["scheduleId" : "",
                         "marginLeft" : 600,
                         "width" : 360,
                         "time" : "03:30-05:00",
                         "fName" : "Events Name",
                         "lName" : "",
                         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFLwF7LgWhRA72rhxs0e9JB1wyCRCLeTFhyN0ySuFMwbX-lTJ2BzicUiDptTa5Z6dynRM&usqp=CAU",
                         "isFav" : true]
                        
                     ]],
                    
                    
                    ["rowIndex" : 2
                     ,"events" : [
                        ["scheduleId" : "",
                         "marginLeft" : 120,
                         "width" : 480,
                         "time" : "01:30-03:30",
                         "fName" : "Events Name",
                         "lName" : "",
                         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdnJT-5rsB7EwKLFXOTENf3mJ6jgNMkHyGbD8sbs91jAgfSGhqBnrVa3CIOUg64bk5OIc&usqp=CAU",
                         "isFav" : true ],
                        
                        ["scheduleId" : "",
                         "marginLeft" : 720,
                         "width" : 240,
                         "time" : "04:00-05:00",
                         "fName" : "Events Name",
                         "lName" : "",
                         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG5z1W2Tv5f34ADLf12gnXwMiHg2AcTill7pvFEmBIEuxbCUkBnop9dwI4nzfCIv5Z8dM&usqp=CAU",
                         "isFav" : false]
                        
                     ]],
                    
                    
                    ["rowIndex" : 3
                     ,"events" : [
                        ["scheduleId" : "",
                         "marginLeft" : 240,
                         "width" : 480,
                         "time" : "02:00-04:00",
                         "fName" : "Events Name",
                         "lName" : "",
                         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBySMsVsVlJJtrKyOBK2p5-EIF6dc0yONQP_dh8IkxJ83m9HVk66jatzip6uNUiM4Y3pY&usqp=CAU",
                         "isFav" : true]
                        
                     ]]
                    
                ]
                , "Days" : [["dayId" : "","dayIndex" : 1]] ]
        }else{
            data = [
                    "id" : "",
                    "fName" : "Events Name",
                    "lName" : "",
                    "date" : "2024-05-06",
                    "dayIndex" : 1,
                    
                    "barUnitWidth" : 1,
                    "firstDate" : "2024-05-05T01:00:00",
                    "lastDate" : "2024-05-05T05:00:00",
                    "hasNewNotifications" : true,
                    
                    "rows" : [
                        
                        ["rowIndex" : 1
                         ,"events" : [
                            ["scheduleId" : "",
                             "marginLeft" : 120,
                             "width" : 480,
                             "time" : "01:30-03:30",
                             "fName" : "Events Name",
                             "lName" : "",
                             "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBySMsVsVlJJtrKyOBK2p5-EIF6dc0yONQP_dh8IkxJ83m9HVk66jatzip6uNUiM4Y3pY&usqp=CAU",
                             "isFav" : true ],
                            
                            ["scheduleId" : "",
                             "marginLeft" : 720,
                             "width" : 240,
                             "time" : "04:00-05:00",
                             "fName" : "Events Name",
                             "lName" : "",
                             "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv_363FC6lZOoIr9YRKT87C7QDEN0IzuSrug&usqp=CAU",
                             "isFav" : false]
                            
                         ]],
                        
                        ["rowIndex" : 2
                         ,"events" : [
                            ["scheduleId" : "",
                             "marginLeft" : 0,
                             "width" : 480,
                             "time" : "01:00-03:00",
                             "fName" : "Events Name",
                             "lName" : "",
                             "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG2CpFLmQ8NJOa6DePo3S6TMnC6Kp33EJvfQ&usqp=CAU",
                             "isFav" : false ],
                            
                            ["scheduleId" : "",
                             "marginLeft" : 600,
                             "width" : 360,
                             "time" : "03:30-05:00",
                             "fName" : "Events Name",
                             "lName" : "",
                             "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGRmolqE5u7barcqEm_7RYuYhGmxC78py7qw&usqp=CAU",
                             "isFav" : true]
                            
                         ]],
                        
                        
                        ["rowIndex" : 3
                         ,"events" : [
                            ["scheduleId" : "",
                             "marginLeft" : 240,
                             "width" : 480,
                             "time" : "02:00-04:00",
                             "fName" : "Events Name",
                             "lName" : "",
                             "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTALulPFtfAt0EB57lRmhtNZkbcVBfG3lLhA&usqp=CAU",
                             "isFav" : true]
                            
                         ]]
                        
                    ]
                    , "Days" : [["dayId" : "","dayIndex" : 1]] ]
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
        self.IsAnimate = true
        self.AddData(data)
        }
        
//    } ArrayOfDictionary: { _ in
//    } Err: { error in
//    self.IfNoData(Data:false)
//    self.SetUpIsError(error, true) {
//    self.GetEventsDay()}
//    }
    }
        
    func AddData(_ array:[String:Any]) {
    EventsDays = DayEvents(Data: array)
    SaveHasNewNotifications(MainScreen(dictionary: array))
        
    SetUpData()
    self.IfNoData(Data:true)
    }
        
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    ViewScroll.isHidden = !Data
    TopViewDate.isHidden = !Data
    self.ViewDots.endRefreshing {}
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetEventsDay), for: .touchUpInside)
    }
    
    func SetUpData() {
        LabelDay.text = EventsDays?.date
        ViewDismiss.TextLabel = "\(EventsDays?.fName?.uppercased() ?? "") \(EventsDays?.lName?.uppercased() ?? "")"
    
        self.HourView.subviews.forEach({$0.removeFromSuperview()})
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
//        let dayIndex = (self.EventsDays?.dayIndex ?? 0)
//        self.YesterDay.alpha = dayIndex > 1 ? 1:0.8
//        self.YesterDay.isEnabled = dayIndex > 1 ? true:false
//            
//        self.NextDay.alpha = dayIndex < (self.EventsDays?.Days.count ?? 0) ? 1:0.8
//        self.NextDay.isEnabled = dayIndex < (self.EventsDays?.Days.count ?? 0) ? true:false
            
            
            
            self.YesterDay.alpha = self.TestdayIndex > 1 ? 1:0.8
            self.YesterDay.isEnabled = self.TestdayIndex > 1 ? true:false
            
            self.NextDay.alpha = self.TestdayIndex < 2 ? 1:0.8
            self.NextDay.isEnabled = self.TestdayIndex < 2 ? true:false
        }
        
        let ForLoop = ForLoopHour(EventsDays?.firstDate ?? "", EventsDays?.lastDate ?? "")
        
        for item in ForLoop {
        let Time = TimeCell()
        Time.Time = item
        Time.translatesAutoresizingMaskIntoConstraints = false
        Time.Label.text = item.Formatter(Format: "yyyy-MM-dd'T'HH:mm:ss").Formatter("hh:mm a")
        Time.widthAnchor.constraint(equalToConstant: ControlWidth(120)).isActive = true
        self.HourView.addArrangedSubview(Time)
        self.ViewScroll.updateContentViewSize(0)
        }
        
        SetUpEvents()
    }
    
    var IsAnimate = true
    func SetUpEvents() {
        self.TimeScroll.subviews.forEach({$0.removeFromSuperview()})
        
        if let rows = self.EventsDays?.rows {
            
        for item in rows {
        let itemEvint = self.IsFav ? item.EventsIsFav : item.events
            
        for itemEvint in itemEvint {
        let view = EvintView()
        view.alpha = 0
        view.Delegate = self
        view.layer.cornerRadius = 15
        view.backgroundColor = .clear
        view.DateLabel.text = itemEvint.time
        view.FNameLabel.text = itemEvint.fName
        view.LNameLabel.text = itemEvint.lName
        view.IsFav = itemEvint.isFav ?? false
        view.ScheduleId = itemEvint.scheduleId
        view.EvintImage.sd_setImage(with: URL(string: itemEvint.image ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        view.FavButton.setBackgroundImage(itemEvint.isFav ?? false ? UIImage(named: "HeartEnabled") : UIImage(named: "HeartNotEnabled"), for: .normal)

        let width = CGFloat(itemEvint.width ?? 0)
        let marginLeft = CGFloat(itemEvint.marginLeft ?? 0 + 60)
        let Y = CGFloat((item.rowIndex ?? 0) - 1) * ControlWidth(170)
  
        if IsAnimate {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: []) {
        view.alpha = 1
        view.frame = CGRect(x: ControlWidth(marginLeft + 60), y: Y, width: ControlWidth(width), height: ControlWidth(150))
        self.TimeScroll.addSubview(view)
        self.TimeScroll.updateContentViewSize(30)
        }
        }else{
        view.alpha = 1
        view.frame = CGRect(x: ControlWidth(marginLeft + 60), y: Y, width: ControlWidth(width), height: ControlWidth(150))
        self.TimeScroll.addSubview(view)
        self.TimeScroll.updateContentViewSize(30)
        }
            
        }
        }
        }
    }
    
    func getAllTime(fromView view: UIView)-> [TimeCell] {
        return view.subviews.flatMap { (view) -> [TimeCell] in
            if view is TimeCell {
                return [(view as! TimeCell)]
            } else {
                return getAllTime(fromView: view)
            }
        }.compactMap({$0})
    }
    
    func ForLoopHour(_ startDate:String,_ endDate:String) -> [String] {
        var mydates : [String] = []
        var dateFrom =  Date()
        var dateTo = Date()

        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        dateFrom = fmt.date(from: startDate) ?? Date()
//        var minute = Calendar.current.component(.minute, from: dateFrom)
//
//        if minute != 0 {
//        minute = minute > 30 ? 30 : 0
//        let hourQuarterDate = Calendar.current.nextDate(after: dateFrom, matching: DateComponents(minute: minute), matchingPolicy: .strict, repeatedTimePolicy: .first, direction: minute > 30 ? .forward : .backward)!
//        dateFrom = hourQuarterDate
//        }
        
        dateTo = fmt.date(from: endDate) ?? Date()
//        var ToComponent    = DateComponents()
//        ToComponent.minute = 30
//        let To             = Calendar.current.date(byAdding: ToComponent, to: dateTo) ?? Date()
    

        while dateFrom <= dateTo {
        mydates.append(fmt.string(from: dateFrom))
        dateFrom = Calendar.current.date(byAdding: .minute, value: 30, to: dateFrom) ?? Date()
        }
        return mydates
    }
    
    func EvintViewActionFav(_ Evint:EvintView) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    ShowMessageAlert("Error", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + AddToFav)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                    "platform": "I",
                                    "deviceID": udid,
                                    "scheduleId": Evint.ScheduleId ?? GUID,
                                    "sqlId": sqlId]
        
    self.ViewDots.beginRefreshing()
    Evint.FavButton.isUserInteractionEnabled = false
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { data in
    self.IsAnimate = false
    self.AddData(data)
    SaveHasNewNotifications(MainScreen(dictionary: data))
    Evint.FavButton.setBackgroundImage(Evint.IsFav == false ? UIImage(named: "HeartEnabled") : UIImage(named: "HeartNotEnabled"), for: .normal)
    Evint.IsFav = !Evint.IsFav
    Evint.FavButton.isUserInteractionEnabled = true
    } ArrayOfDictionary: { _ in
    } Err: { Error in
    self.ViewDots.endRefreshing(Error, .error) {}
    Evint.FavButton.isUserInteractionEnabled = true
    }
    }
}



