//
//  EventsVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import SDWebImage

class EventsVC: ViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    var EventsData = [MainEvents]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItem()
        view.backgroundColor = .white
    }

    fileprivate func SetUpItem() {
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(EventsLabel)
        EventsLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        EventsLabel.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(5)).isActive = true
        EventsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        EventsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(MenuTapCollection)
        MenuTapCollection.fixedSegmentWidth = true
        MenuTapCollection.selectedSegmentIndex = 0
        MenuTapCollection.underlineSelected = true
        MenuTapCollection.heightAnchor.constraint(equalToConstant: ControlWidth(35)).isActive = true
        MenuTapCollection.topAnchor.constraint(equalTo: EventsLabel.bottomAnchor).isActive = true
        MenuTapCollection.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        MenuTapCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true

        view.addSubview(EventsCollection)
        EventsCollection.topAnchor.constraint(equalTo: MenuTapCollection.bottomAnchor,constant: ControlY(20)).isActive = true
        EventsCollection.widthAnchor.constraint(equalTo: view.widthAnchor,constant: ControlX(60)).isActive = true
        EventsCollection.heightAnchor.constraint(equalTo: view.heightAnchor,constant: ControlY(-290)).isActive = true
        EventsCollection.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(-90)).isActive = true
        
    }

    let largerRedTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Regular", size: ControlWidth(15.5)),
                                   NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
    let largerRedTextHighlightAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: ControlWidth(16)),
                                            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    let largerRedTextSelectAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: ControlWidth(16)),
                                         NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    

    lazy var MenuTapCollection : ScrollableSegmentedControl = {
        let View = ScrollableSegmentedControl()
        View.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        View.isHidden = true
        View.segmentStyle = .textOnly
        View.underlineHeight = ControlWidth(2)
        View.translatesAutoresizingMaskIntoConstraints = false
        View.insertSegment(withTitle: "Upcoming".localizable, image: nil, at: 0)
        View.insertSegment(withTitle: "All Days".localizable, image: nil, at: 1)
        View.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        View.setTitleTextAttributes(largerRedTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        View.setTitleTextAttributes(largerRedTextHighlightAttributes as [NSAttributedString.Key : Any], for: .highlighted)
        View.setTitleTextAttributes(largerRedTextSelectAttributes as [NSAttributedString.Key : Any], for: .selected)
        return View
    }()
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        skip = 0
        let IsUpcoming = sender.selectedSegmentIndex == 0 ? true : false
        GetEventsData(removeAll: true, ShowDots: true, IsUpcoming: IsUpcoming)
    }

    lazy var EventsLabel : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Explore our".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "Events".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    

    let EventsID = "Events"
    lazy var EventsCollection: CollectionAnimations = {
        let layout = CardsCollectionViewLayout()
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true
        vc.bounces = false
        vc.clipsToBounds = false
        vc.isPagingEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(EventsCell.self, forCellWithReuseIdentifier: EventsID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return EventsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventsID, for: indexPath) as! EventsCell
        cell.backgroundColor = .clear
        cell.SetTextName(EventsData[indexPath.item].fName ?? "", EventsData[indexPath.item].lName ?? "")
        cell.ImageView.sd_setImage(with: URL(string: EventsData[indexPath.item].image  ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let DayEvents = DayEventsVC()
        DayEvents.dayId = EventsData[indexPath.item].dayId
        DayEvents.ViewDismiss.TextLabel = "\(EventsData[indexPath.item].fName ?? "")"
        Present(ViewController: self, ToViewController: DayEvents)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        if contentOffsetX >= (scrollView.contentSize.width - scrollView.bounds.width) - 20 /* Needed offset */ {
        guard !self.fetchingMore else { return }
        self.fetchingMore = true
            
        let MenuTapCollection = MenuTapCollection.selectedSegmentIndex == 0 ? true : false
        self.GetEventsData(removeAll: false, ShowDots: true, IsUpcoming: MenuTapCollection)
        }
    }

    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func GetEventsData(removeAll:Bool = false, ShowDots:Bool = true, IsUpcoming:Bool = true) {
//    let IfIsUpcoming = IsUpcoming ? GetAllDaysEvents : GetUpcomingEvents
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    self.ViewDots.endRefreshing {}
//    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + IfIsUpcoming)"
//        
//    let carnavalId = defaults.string(forKey: "carnavalId") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
//                                   "platform": "I",
//                                   "deviceID": udid,
//                                   "carnavalId": carnavalId,
//                                   "take": 10,
//                                   "skip": skip]
//        
    if ShowDots {self.ViewDots.beginRefreshing()}
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        var data = [[String:Any]]()
        
        if IsUpcoming {
            data = [
                ["id" : "",
                 "dayId" : "",
                 "date" : "2023-12-05",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6GMm82ctxHQHkbdTQOQ_m3mH_GaT7ZqQIsOKThsgj0mAZPBFbSTNdKut2guC3ZHs-tcc&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-05-06",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFLwF7LgWhRA72rhxs0e9JB1wyCRCLeTFhyN0ySuFMwbX-lTJ2BzicUiDptTa5Z6dynRM&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2023-12-07",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdnJT-5rsB7EwKLFXOTENf3mJ6jgNMkHyGbD8sbs91jAgfSGhqBnrVa3CIOUg64bk5OIc&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-05-08",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG5z1W2Tv5f34ADLf12gnXwMiHg2AcTill7pvFEmBIEuxbCUkBnop9dwI4nzfCIv5Z8dM&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2023-11-30",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBySMsVsVlJJtrKyOBK2p5-EIF6dc0yONQP_dh8IkxJ83m9HVk66jatzip6uNUiM4Y3pY&usqp=CAU"],
            ]
        }else{
            data = [
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-06-05",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBySMsVsVlJJtrKyOBK2p5-EIF6dc0yONQP_dh8IkxJ83m9HVk66jatzip6uNUiM4Y3pY&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-06-06",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv_363FC6lZOoIr9YRKT87C7QDEN0IzuSrug&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-06-07",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG2CpFLmQ8NJOa6DePo3S6TMnC6Kp33EJvfQ&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-06-08",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGRmolqE5u7barcqEm_7RYuYhGmxC78py7qw&usqp=CAU"],
                ["id" : "",
                 "dayId" : "",
                 "date" : "2024-06-09",
                 "startIn" : "01:00",
                 "endIn" : "05:00",
                 "fName" : "Events Name",
                 "lName" : "",
                 "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTALulPFtfAt0EB57lRmhtNZkbcVBfG3lLhA&usqp=CAU"],
            ]
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if removeAll {
                self.EventsCollection.RemoveAnimations {
                    self.EventsData.removeAll()
                    self.Animations = true
                    self.AddData(data)
                }
            }else{
                self.AddData(data)
            }
        }
        
//    } Err: { error in
//    if self.EventsData.count != 0 {
//    return
//    }else{
//    self.IfNoData()
//    self.SetUpIsError(error, true) {
//    self.GetEventsData()}
//    }
//    }
    }
    
    func AddData(_ array:[[String:Any]]) {
        for item in array {
        EventsData.append(MainEvents(dictionary: item))
        self.skip += 1
        self.fetchingMore = false
        if EventsData.count == array.count {
        self.EventsCollection.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
        self.Animations == true ? self.EventsCollection.SetAnimations() {self.Animations = false} : self.EventsCollection.reloadData()
        }else{
        self.EventsCollection.reloadData()
        }
        }
        self.IfNoData()
    }
    
    @objc func refresh() {
    skip = 0
    GetEventsData(removeAll: true)
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.EventsData.count != 0 ? true : false
    self.EventsCollection.isHidden = self.EventsData.count == 0 ? true : false
    self.MenuTapCollection.isHidden = self.EventsData.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
    
}

