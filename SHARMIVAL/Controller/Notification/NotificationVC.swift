//
//  NotificationVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 29/03/2022.
//

import UIKit

class NotificationVC: ViewController, UITableViewDelegate, UITableViewDataSource ,NotificationsDelegate ,SwipeTableViewCellDelegate {
    
    let NotificationsID = "Notifications"
    var NotificationsData = [Notifications]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        LodNotifications()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    fileprivate func SetUpItems() {
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.ShowNotifications = false
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(ViewDismiss)
        ViewDismiss.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(5)).isActive = true
        ViewDismiss.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ControlX(15)).isActive = true
        ViewDismiss.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        ViewDismiss.heightAnchor.constraint(equalToConstant: ControlWidth(50)).isActive = true
        
        view.addSubview(TableView)
        TableView.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: AppDelegate.PostNotification , object: nil)
    }
        
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.TextLabel = "Notification".localizable
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
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = true
        tv.rowHeight = ControlWidth(80)
        
        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        tv.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tv.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsID)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(15), right: 0)
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NotificationsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsID, for: indexPath) as! NotificationsCell
        if indexPath.row == 0 {
        cell.ViewLine.isHidden = true
        }else{
        cell.ViewLine.isHidden = false
        }
        
        cell.Delegate = self
        cell.delegate = self
        cell.selectionStyle = .none
        cell.LabelDate.text = NotificationsData[indexPath.item].date ?? ""
        cell.LabelTitle.text = NotificationsData[indexPath.item].notTitle
        cell.ColorView.backgroundColor = NotificationsData[indexPath.item].Color
        cell.LabelDate.alpha = NotificationsData[indexPath.row].readable ?? true ? 0.5 : 1
        cell.LabelTitle.alpha = NotificationsData[indexPath.row].readable ?? true ? 0.5 : 1
        cell.ColorView.alpha = NotificationsData[indexPath.row].readable ?? true ? 0.5 : 1
        return cell
    }


    var SelectIndex = IndexPath()
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    if "lang".localizable == "ar" {
    guard orientation == .left else { return nil }
    }else{
    guard orientation == .right else { return nil }
    }
    let deleteAction = SwipeAction(style: .destructive, title: nil) { action, index in
        
    self.SelectIndex = indexPath
    ShowMessageAlert("ErrorIcon", "Delete Notification".localizable, "Are You Sure You Want to Delete this Notifications".localizable, false, self.ActionDelete, "Delete".localizable)
    }

    deleteAction.image = UIImage(named: "NotificationDelete")
    deleteAction.backgroundColor = .white
    return [deleteAction]
    }
    
    func ActionDelete() {
    guard let id = NotificationsData[SelectIndex.row].id else{return}
    ReadableORDelete(Id:id,Read: false)
    }
    
    var defaultOptions = SwipeOptions()
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        if "lang".localizable == "ar" {
        options.expansionStyle = orientation == .left ? .selection : .destructive
        }else{
        options.expansionStyle = orientation == .right ? .selection : .destructive
        }
        options.transitionStyle = defaultOptions.transitionStyle
        options.backgroundColor = .white
        return options
    }

    func ActionView(cell: NotificationsCell) {
    if let index = TableView.indexPath(for: cell) {
    if let Details = NotificationsData[index.row].notDetails ,let date = NotificationsData[index.row].date ,let id = NotificationsData[index.row].id ,let Title = NotificationsData[index.row].notTitle {
    if NotificationsData[index.row].readable == false {ReadableORDelete(Id:id,index:index, Read: true)}
    let NotificationsDetails = NotificationsDetailsVC()
    NotificationsDetails.Message.text = Details
    NotificationsDetails.LabelDate.text = date
    NotificationsDetails.ViewDismiss.TextLabel = Title
    Present(ViewController: self, ToViewController: NotificationsDetails)
    }
    }
    }
    
    
    func ReadableORDelete(Id:String,index:IndexPath = IndexPath(),Read:Bool) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }
    let Url = Read == true ? ApiReadNotification : ApiDeleteNotification

    let api = "\(url + Url)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "platform": "I",
                                   "deviceID": udid,
                                   "sqlId": sqlId,
                                   "notId": Id]

    if !Read {self.ViewDots.beginRefreshing()}
    PostAPI(api: api, token: token, parameters: parameters) { _ in

    } DictionaryData: { data in
    SaveHasNewNotifications(MainScreen(dictionary: data))
        
    if Read == true {
    self.NotificationsData[index.row].readable = true
    self.TableView.reloadRows(at: [index], with: .automatic)
    }else{
    if self.NotificationsData[self.SelectIndex.row].readable == false {
    self.TableView.reloadRows(at: [self.SelectIndex], with: .automatic)
    }
    self.NotificationsData.remove(at: self.SelectIndex.row)
    self.TableView.beginUpdates()
    self.TableView.deleteRows(at: [IndexPath(row: self.SelectIndex.row, section: 0)], with: .right)
    self.TableView.endUpdates()
    self.IfNoData()
    }

    } ArrayOfDictionary: { _ in
    } Err: { error in
    if !Read {self.ViewDots.endRefreshing(error, .error) {}}else{}
    }
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func LodNotifications(removeAll:Bool = false, ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + ApiGetNotification)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let sqlId = defaults.string(forKey: "sqlId") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "platform": "I",
                                   "deviceID": udid,
                                   "sqlId": sqlId,
                                   "take": 15,
                                   "skip": skip]
        
    fetchingMore = true
    if ShowDots {self.ViewDots.beginRefreshing()}
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
        
    if removeAll {
    self.TableView.RemoveAnimations {
    self.NotificationsData.removeAll()
    self.Animations = true
    self.AddData(data)
    }
    }else{
    self.AddData(data)
    }
        
    } Err: { error in
    if self.NotificationsData.count != 0 {
    return
    }else{
    self.IfNoData()
    self.SetUpIsError(error,true) {self.refresh()}
    }
    }
    }
    
    func AddData(_ array:[[String:Any]]) {
    for item in array {
    self.NotificationsData.append(Notifications(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    if NotificationsData.count == array.count {
    self.Animations == true ? self.TableView.SetAnimations() {self.Animations = false} : self.TableView.reloadData()
    }else{
    self.TableView.reloadData()
    }
    }
    self.IfNoData()
    }
    
    
    @objc func refresh() {
    skip = 0
    LodNotifications(removeAll: true)
    }
    
    func IfNoData() {
    if self.NotificationsData.count != 0 {
    ViewNoData.MessageDetails = "Something went wrong while processing your request, please try again later".localizable
    }else{
    ViewNoData.MessageDetails = "Not Found".localizable
    }
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.NotificationsData.count != 0 ? true : false
    self.TableView.isHidden = self.NotificationsData.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    SetUpButton()
    }
    
}

extension NotificationVC: KRPullLoadViewDelegate {
    
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.LodNotifications(removeAll: false, ShowDots: false)
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

