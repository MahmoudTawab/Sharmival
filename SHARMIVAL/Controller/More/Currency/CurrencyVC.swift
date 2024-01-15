//
//  CurrencyVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit

class CurrencyVC: ViewController , UITableViewDelegate, UITableViewDataSource, CurrencyCollectionDelegate {
    
    
    let CurrencyColor = [ColorGenerator.sharedInstance.next(),ColorGenerator.sharedInstance.next()]
    let CurrencyDetails = ["“A cashless payment method that facilitates to you the payment process in Sharmival”".localizable,"“Used for buying anything from the Bazars, Stores and F&B Kiosks”".localizable]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        TableView.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(10)).isActive = true
        TableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
        
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.TextLabel = "Currency".localizable
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(35), height: ControlWidth(35))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }

    let CurrencyId = "CurrencyId"
    let CollectionCellId = "CollectionCellId"
    lazy var TableView : TableViewAnimations = {
        let tv = TableViewAnimations()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.alwaysBounceVertical = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyId)
        tv.register(CurrencyCollectionCell.self, forCellReuseIdentifier: CollectionCellId)
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(15), right: 0)
        return tv
    }()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? CurrencyDetails.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyId, for: indexPath) as! CurrencyCell
        cell.selectionStyle = .none
            
        cell.LabelTitle.text = CurrencyDetails[indexPath.row]
        cell.ColorView.backgroundColor = CurrencyColor[indexPath.row]
        return cell
        }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionCellId, for: indexPath) as! CurrencyCollectionCell
        cell.selectionStyle = .none
        cell.Delegate = self
        return cell
        }
    }
    
    func ActionLocations() {
    let TabBar = TabBarController()
    TabBar.selectedIndex = 3
    FirstController(TabBar)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : ControlWidth(330)
    }


}
