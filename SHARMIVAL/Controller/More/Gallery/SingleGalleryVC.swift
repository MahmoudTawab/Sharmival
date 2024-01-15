//
//  SingleGalleryVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 29/09/2022.
//

import UIKit
import SDWebImage

class SingleGalleryVC: ViewController , UICollectionViewDataSource ,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, CollectionViewWaterfallLayoutDelegate  {
        
    var Id : String?
    var Header : String?
    var SingleGalleryImage = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItems()
        LodSingleGallery()
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
        
        vc.showsVerticalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(GallerCell.self, forCellWithReuseIdentifier: GalleryID)
        vc.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ControlX(10), right: 0)
        vc.register(GallerHeader.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        vc.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        return vc
    }()
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SingleGalleryImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryID, for: indexPath) as! GallerCell
        cell.backgroundColor = .clear
        cell.ImageView.image = SingleGalleryImage[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GallerCell
        
        let datasource = FMImageDataSource(images: SingleGalleryImage)
        let config = Config(initImageView: cell.ImageView, initIndex: indexPath.item)
        let fmImageVC = FMImageSlideViewController(datasource: datasource, config: config)
        fmImageVC.view.frame = cell.ImageView.frame
        
        fmImageVC.didMoveToViewControllerHandler = { index in
        DispatchQueue.main.async {
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .bottom, animated: false)
        if let CellMove = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? GallerCell {
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
    header.TitleLabel.text = Header ?? "photos".localizable
    return header

    case CollectionViewWaterfallElementKindSectionFooter:
    let Footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
    Footer.backgroundColor = .clear
    return Footer
    default:
    fatalError("Unexpected element kind")
    }
    }
    
    @objc func LodSingleGallery() {
    guard let url = defaults.string(forKey: "API") else{
    LodBaseUrl()
    self.ViewDots.endRefreshing {}
    ShowMessageAlert("ErrorIcon", "Error".localizable, "Something went wrong while processing your request, please try again later".localizable, true, {})
    return
    }

    let api = "\(url + GetAlbumDetails)"
    let token = defaults.string(forKey: "jwt") ?? ""
    let udid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let parameters:[String:Any] = ["appId": "513faa96-afb6-4171-8d74-1a04c19092d6",
                                   "platform": "I",
                                   "deviceID": udid,
                                   "albumId": Id ?? GUID]
        
    self.ViewDots.beginRefreshing()
    PostAPI(api: api, token: token, parameters: parameters) { _ in
    } DictionaryData: { _ in
    } ArrayOfDictionary: { data in
    self.AddData(data)
    } Err: { error in
    self.IfNoData(false)
    self.SetUpIsError(error,true) {self.LodSingleGallery()}
    }
    }
    
    func AddData(_ dictionary:[[String:Any]]) {
    for item in dictionary {
    if let Url = URL(string: MainGallery(dictionary: item).image ?? "") {
    SDWebImageManager.shared.loadImage(
    with: Url,
    options: .highPriority,
    progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
    if let GalleryImage = image {
    self.SingleGalleryImage.append(GalleryImage)
    self.IfNoData(true)
    }else{
    self.SingleGalleryImage.append(UIImage(named: "Group 26056") ?? UIImage())
    self.IfNoData(true)
    }
    }
    }
    }
    }
    
    func IfNoData(_ IsNoData:Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    self.ViewNoData.RefreshButton.addTarget(self, action: #selector(self.LodSingleGallery), for: .touchUpInside)
    self.ViewNoData.isHidden = IsNoData
    self.GalleryCollection.isHidden = !IsNoData
    self.GalleryCollection.SetAnimations()
    self.ViewDots.endRefreshing(){}
    }
    }
    
}

