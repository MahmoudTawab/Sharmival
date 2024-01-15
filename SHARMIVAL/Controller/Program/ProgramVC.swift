//
//  ProgramVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import SDWebImage

class ProgramVC: ViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    var ProgramData = [MainEvents]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItem()
        GetProgramData()
        view.backgroundColor = .white
    }
    
    fileprivate func SetUpItem() {
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(ProgramLabel)
        ProgramLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ProgramLabel.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(10)).isActive = true
        ProgramLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        ProgramLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true

        view.addSubview(ProgramCollection)
        ProgramCollection.topAnchor.constraint(equalTo: ProgramLabel.bottomAnchor).isActive = true
        ProgramCollection.widthAnchor.constraint(equalTo: view.widthAnchor,constant: ControlX(60)).isActive = true
        ProgramCollection.heightAnchor.constraint(equalTo: view.heightAnchor,constant: ControlY(-230)).isActive = true
        ProgramCollection.leftAnchor.constraint(equalTo: view.leftAnchor,constant: ControlX(-90)).isActive = true
    }


    lazy var ProgramLabel : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Explore our".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "Program".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    

    let ProgramID = "Program"
    lazy var ProgramCollection: UICollectionView = {
        let layout = CardsCollectionViewLayout()
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .clear
        vc.dataSource = self
        vc.delegate = self
        vc.bounces = false
        vc.isHidden = true
        vc.isPagingEnabled = true
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(ProgramCell.self, forCellWithReuseIdentifier: ProgramID)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProgramData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramID, for: indexPath) as! ProgramCell
        cell.backgroundColor = .clear
        cell.FName.textAlignment = .center
        cell.LName.textAlignment = .center
        cell.FName.text = ProgramData[indexPath.item].fName?.uppercased()
        cell.LName.text = "lang".localizable == "ar" ? ProgramData[indexPath.item].lName?.NumAR() : ProgramData[indexPath.item].lName
        cell.ImageView.sd_setImage(with: URL(string: ProgramData[indexPath.item].image  ?? ""), placeholderImage: UIImage(named: "Group 26056"))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let DayEvents = DayEventsVC()
    DayEvents.dayId = ProgramData[indexPath.item].id
    DayEvents.ViewDismiss.TextLabel = "\(ProgramData[indexPath.item].fName?.uppercased() ?? "") \(ProgramData[indexPath.item].lName?.uppercased() ?? "")"
    Present(ViewController: self, ToViewController: DayEvents)
    }
    
    @objc func GetProgramData() {
//    guard let url = defaults.string(forKey: "API") else{
//    LodBaseUrl()
//    self.ViewDots.endRefreshing {}
//    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
//    return
//    }
//    let token = defaults.string(forKey: "jwt") ?? ""
//    let api = "\(url + ApiGetProgram)"
//        
//    let carnavalId = defaults.string(forKey: "carnavalId") ?? ""
//    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
//                                   "platform": "I",
//                                   "deviceID": udid,
//                                   "carnavalId": carnavalId]
        
    self.ViewDots.beginRefreshing()
//    PostAPI(api: api, token: token, parameters: parameters) { _ in
//    } DictionaryData: { _ in
//    } ArrayOfDictionary: { data in
        
        let data = [
        ["id" : "",
         "dayId" : "",
         "date" : "2024-05-05",
         "startIn" : "01:00",
         "endIn" : "05:00",
         "fName" : "Event",
         "lName" : "",
         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6GMm82ctxHQHkbdTQOQ_m3mH_GaT7ZqQIsOKThsgj0mAZPBFbSTNdKut2guC3ZHs-tcc&usqp=CAU"],
        ["id" : "",
         "dayId" : "",
         "date" : "2024-05-06",
         "startIn" : "01:00",
         "endIn" : "05:00",
         "fName" : "Event",
         "lName" : "",
         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFLwF7LgWhRA72rhxs0e9JB1wyCRCLeTFhyN0ySuFMwbX-lTJ2BzicUiDptTa5Z6dynRM&usqp=CAU"],
        ["id" : "",
         "dayId" : "",
         "date" : "2024-05-07",
         "startIn" : "01:00",
         "endIn" : "05:00",
         "fName" : "Event",
         "lName" : "",
         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdnJT-5rsB7EwKLFXOTENf3mJ6jgNMkHyGbD8sbs91jAgfSGhqBnrVa3CIOUg64bk5OIc&usqp=CAU"],
        ["id" : "",
         "dayId" : "",
         "date" : "2024-05-08",
         "startIn" : "01:00",
         "endIn" : "05:00",
         "fName" : "Event",
         "lName" : "",
         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSG5z1W2Tv5f34ADLf12gnXwMiHg2AcTill7pvFEmBIEuxbCUkBnop9dwI4nzfCIv5Z8dM&usqp=CAU"],
        ["id" : "",
         "dayId" : "",
         "date" : "2024-05-09",
         "startIn" : "01:00",
         "endIn" : "05:00",
         "fName" : "Event",
         "lName" : "",
         "image" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBySMsVsVlJJtrKyOBK2p5-EIF6dc0yONQP_dh8IkxJ83m9HVk66jatzip6uNUiM4Y3pY&usqp=CAU"],
        ]
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
        self.AddData(data)
        }
//    } Err: { error in
//    self.IfNoData(Data:false)
//    self.SetUpIsError(error, true) {
//    self.GetProgramData()}
//    }
    }
    
    func AddData(_ array:[[String:Any]]) {
        for item in array {
        ProgramData.append(MainEvents(dictionary: item))
        ProgramCollection.reloadData()
        }
        self.IfNoData(Data:true)
    }
    
    func IfNoData(Data:Bool) {
    ViewNoData.isHidden = Data
    self.ViewDots.endRefreshing {}
    ProgramCollection.isHidden = !Data
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(GetProgramData), for: .touchUpInside)
    }

    
    
}
