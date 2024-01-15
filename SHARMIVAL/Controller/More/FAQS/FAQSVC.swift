//
//  FAQSVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit

class FAQSVC: ViewController , UITableViewDelegate , UITableViewDataSource {
    
    let FAQSID = "FAQS"
    var FaqsData = [Faqs]()
    override func viewDidLoad() {
        super.viewDidLoad()
        LodFaqs()
        SetUpItems()
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
        
        view.addSubview(TableView)
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TableView.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
    }
        
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.TextLabel = "FAQS".localizable
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(35), height: ControlWidth(35))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.isHidden = true
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.indicatorStyle = .black
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = true
        tv.rowHeight = UITableView.automaticDimension
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(FAQCell.self, forCellReuseIdentifier: FAQSID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(15), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FaqsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FAQSID, for: indexPath) as! FAQCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        cell.TextTitle.text = FaqsData[indexPath.row].q
        cell.TheDetails.text = FaqsData[indexPath.row].a
        cell.TheDetails.isHidden = FaqsData[indexPath.row].FAQHidden
        
        cell.ViewBackground.backgroundColor = FaqsData[indexPath.row].Color
        cell.TheDetails.addInterlineSpacing(spacingValue: ControlWidth(4))
        cell.OpenClose.transform = FaqsData[indexPath.row].FAQHidden == false ? .identity:CGAffineTransform(rotationAngle: "lang".localizable == "ar" ? (.pi / 2):(-.pi / 2))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    FaqsData[indexPath.row].FAQHidden = !FaqsData[indexPath.row].FAQHidden
    TableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func LodFaqs(removeAll:Bool = false, ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + GetFAQS)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "platform": "I",
                                   "deviceID": udid,
                                   "take": 15,
                                   "skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
        
    if removeAll {
    self.TableView.RemoveAnimations {
    self.FaqsData.removeAll()
    self.Animations = true
    self.AddData(data)
    }
    }else{
    self.AddData(data)
    }
                        
    } Err: { error in
    if self.FaqsData.count != 0 {
    return
    }else{
    self.IfNoData()
    self.SetUpIsError(error,true) {self.refresh()}
    }
    }
    }
    
    func AddData(_ array:[[String:Any]]) {
    for item in array {
    self.FaqsData.append(Faqs(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    if FaqsData.count == array.count {
    self.Animations == true ? self.TableView.SetAnimations() {self.Animations = false} : self.TableView.reloadData()
    }else{
    self.TableView.reloadData()
    }
    }
    self.IfNoData()
    }
    
    @objc func refresh() {
    skip = 0
    LodFaqs(removeAll: true)
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.FaqsData.count != 0 ? true : false
    self.TableView.isHidden = self.FaqsData.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
    
}

extension FAQSVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.LodFaqs(removeAll: false, ShowDots: false)
        }
        default: break
        }
        return
        }

        switch state {
        case .none:
        pullLoadView.messageLabel.text = ""
        case .pulling(_, _):
        pullLoadView.messageLabel.text = "Pull more".localizable
        case let .loading(completionHandler):
        pullLoadView.messageLabel.text = "Updating".localizable
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.refresh()
        }
        }
        return
        }
}

