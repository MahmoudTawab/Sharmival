//
//  AllGalleryVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit
import SDWebImage

class AllGalleryVC: ViewController , UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, CollectionViewWaterfallLayoutDelegate  {
        
    var Gallery = [MainGallery]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        LodGallery()
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
        
        view.addSubview(GalleryCollection)
        GalleryCollection.topAnchor.constraint(equalTo: ViewDismiss.bottomAnchor, constant: ControlY(5)).isActive = true
        GalleryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        GalleryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        GalleryCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
        
    lazy var ViewDismiss : ImageAndLabel = {
        let View = ImageAndLabel()
        View.backgroundColor = .clear
        View.TextLabel = "Gallery".localizable
        View.translatesAutoresizingMaskIntoConstraints = false
        View.IconSize = CGSize(width: ControlWidth(35), height: ControlWidth(35))
        View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        View.IconImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Dismiss)))
        return View
    }()
    
    @objc func Dismiss() {
    self.navigationController?.popViewController(animated: true)
    }
    
    
    let GalleryID = "Gallery"
    lazy var GalleryCollection: CollectionAnimations = {
        let layout = CollectionViewWaterfallLayout()
        
        layout.footerHeight = Float(0)
        layout.headerHeight = Float(ControlWidth(35))
        layout.minimumColumnSpacing = Float(ControlX(10))
        layout.minimumInteritemSpacing = Float(ControlX(10))
        layout.headerInset = UIEdgeInsets(top: ControlX(5), left: 0, bottom: 0, right: 0)
        layout.sectionInset = UIEdgeInsets(top: ControlX(10), left: ControlX(10), bottom: ControlX(10), right: ControlX(10))
        
        let vc = CollectionAnimations(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.isHidden = true

        let refreshView = KRPullLoadView()
        refreshView.delegate = self
        vc.addPullLoadableView(refreshView, type: .refresh)
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        vc.addPullLoadableView(loadMoreView, type: .loadMore)
        
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(GallerCell.self, forCellWithReuseIdentifier: GalleryID)
        vc.register(GallerHeader.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        return vc
    }()
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Gallery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Gallery[section].details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryID, for: indexPath) as! GallerCell
        cell.backgroundColor = .clear
        
        if indexPath.item < Gallery[indexPath.section].details.count {
        if let ImageDetails = Gallery[indexPath.section].details[indexPath.item].image {
        cell.ImageView.image = ImageDetails
        }
        }else{
        cell.ImageView.image = UIImage(named: "Group 26056")
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GallerCell
        
        let datasource = FMImageDataSource(images: Gallery[indexPath.section].ImagesDetails)
        let config = Config(initImageView: cell.ImageView, initIndex: indexPath.item)
        let fmImageVC = FMImageSlideViewController(datasource: datasource, config: config)
        fmImageVC.view.frame = cell.ImageView.frame
        
        fmImageVC.didMoveToViewControllerHandler = { index in
        DispatchQueue.main.async {
        collectionView.scrollToItem(at: IndexPath(item: index, section: indexPath.section), at: .bottom, animated: false)
        if let CellMove = collectionView.cellForItem(at: IndexPath(item: index, section: indexPath.section)) as? GallerCell {
        fmImageVC.setNewDestinatonFrame(imageView: CellMove.ImageView)
        }else{
        fmImageVC.setNewDestinatonFrame(imageView: cell.ImageView)
        }
        }
        }
        
        self.present(fmImageVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
    let height = indexPath.item % 4 == 0 || indexPath.item % 4 == 3 ? ControlWidth(200):ControlWidth(300)
    return CGSize(width: collectionView.frame.width / 2, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case CollectionViewWaterfallElementKindSectionHeader:
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! GallerHeader
    header.backgroundColor = .clear
    header.TitleLabel.text = Gallery[indexPath.section].name
    return header

    case CollectionViewWaterfallElementKindSectionFooter:
    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
    Footer.backgroundColor = .clear
    return Footer
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    var skip = 0
    var Animations = true
    var fetchingMore = false
    @objc func LodGallery(removeAll:Bool = false, ShowDots:Bool = true) {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + GetGallery)"
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
    self.GalleryCollection.RemoveAnimations {
    self.Gallery.removeAll()
    self.Animations = true
    self.AddData(data)
    }
    }else{
    self.AddData(data)
    }
                        
    } Err: { error in
    if self.Gallery.count != 0 {
    return
    }else{
    self.IfNoData()
    self.SetUpIsError(error,true) {self.refresh()}
    }
    }
    }
    
    func AddData(_ dictionary:[[String:Any]]) {
    for item in dictionary {
    self.Gallery.append(MainGallery(dictionary: item))
    self.skip += 1
    self.fetchingMore = false
    self.Animations == true ? self.GalleryCollection.SetAnimations() {self.Animations = false} : self.GalleryCollection.reloadData()
    }
    self.IfNoData()
    }
    
    @objc func refresh() {
    skip = 0
    LodGallery(removeAll: true)
    }
    
    func IfNoData() {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    self.ViewNoData.isHidden = self.Gallery.count != 0 ? true : false
    self.GalleryCollection.isHidden = self.Gallery.count == 0 ? true : false
    self.ViewDots.endRefreshing(){}
    }
    
}

extension AllGalleryVC: KRPullLoadViewDelegate {
        func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
        switch state {
        case let .loading(completionHandler):
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
        completionHandler()
        self.LodGallery(removeAll: false, ShowDots: false)
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

