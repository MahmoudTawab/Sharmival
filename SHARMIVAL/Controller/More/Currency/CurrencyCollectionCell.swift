//
//  CurrencyCollectionCell.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import UIKit

protocol CurrencyCollectionDelegate {
    func ActionLocations()
}

class CurrencyCollectionCell: UITableViewCell ,UICollectionViewDelegate, UICollectionViewDataSource {

    var itemWidth = CGFloat(0)
    let CurrencyCollId = "CurrencyColl"
    let collectionMargin = CGFloat(0)
    let itemSpacing = ControlWidth(8)
    let itemHeight = ControlWidth(210)
    let CurrencyCellColor = [#colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1), #colorLiteral(red: 0.874769628, green: 0.1164482012, blue: 0.5446254611, alpha: 1)]
    var Delegate : CurrencyCollectionDelegate?
    let CurrencyCellTitle = ["Get Bracelet".localizable,"Scan".localizable]
    let CurrencyCellDetails = ["Guest goes to top up booth to create a card / bracelet with their own associated data and add balance".localizable,"Staff scan guest’s card/bracelet to place an order from the menu".localizable]
    lazy var CurrencyCollection  : UICollectionView = {
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
        vc.register(CurrencyCellCollection.self, forCellWithReuseIdentifier: CurrencyCollId)
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CurrencyCellColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollId,for: indexPath) as! CurrencyCellCollection
        cell.roundCorners(topLeft: ControlX(8), topRight: ControlX(8), bottomLeft: 0, bottomRight: 0)
        cell.backgroundColor = CurrencyCellColor[indexPath.item]
        cell.TitleLabel.text = CurrencyCellTitle[indexPath.item]
        cell.DetailsTV.text = CurrencyCellDetails[indexPath.item]
        return cell
    }
    
    lazy var ViewLocations : ButtonNotEnabled = {
        let Button = ButtonNotEnabled()
        let Title = "lang".localizable == "ar" ? "  " + "View locations on the map".localizable : "View locations on the map".localizable + "  "
        Button.tintColor = #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)
        Button.backgroundColor = .clear
        Button.setTitle(Title, for: .normal)
        Button.semanticContentAttribute = .forceRightToLeft
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
        Button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: ControlWidth(18))
        Button.contentHorizontalAlignment = "lang".localizable == "ar" ? .right : .left
        Button.addTarget(self, action: #selector(ActionLocations), for: .touchUpInside)
        Button.contentEdgeInsets = UIEdgeInsets(top: ControlY(4), left: 0, bottom: ControlY(4), right: 0)
        Button.setTitleColor(#colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1), for: .normal)
        Button.setImage(UIImage(named: "right-arrow")?.imageWithImage(scaledToSize: CGSize(width: ControlWidth(16), height: ControlWidth(16))), for: .normal)
        return Button
    }()

    @objc func ActionLocations() {
        Delegate?.ActionLocations()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        contentView.isHidden = true
   
        addSubview(CurrencyCollection)
        CurrencyCollection.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        CurrencyCollection.topAnchor.constraint(equalTo: topAnchor,constant: ControlX(15)).isActive = true
        CurrencyCollection.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(15)).isActive = true
        CurrencyCollection.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-15)).isActive = true
        
        addSubview(ViewLocations)
        ViewLocations.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        ViewLocations.bottomAnchor.constraint(equalTo: bottomAnchor,constant: ControlX(-15)).isActive = true
        ViewLocations.leadingAnchor.constraint(equalTo: leadingAnchor,constant: ControlX(15)).isActive = true
        ViewLocations.trailingAnchor.constraint(equalTo: trailingAnchor,constant: ControlX(-15)).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

}

class CurrencyCellCollection: UICollectionViewCell {
    
    lazy var TitleLabel : UILabel = {
        let Label = UILabel()
        Label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        Label.backgroundColor = .clear
        Label.translatesAutoresizingMaskIntoConstraints = false
        Label.font = UIFont(name: "Poppins-Medium" ,size: ControlWidth(18))
        return Label
    }()
    
    lazy var TitleImage : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = false
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Group 58523")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.widthAnchor.constraint(equalToConstant: ControlWidth(40)).isActive = true
        return ImageView
    }()
    
    
    lazy var TopStack : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TitleLabel,TitleImage])
        Stack.axis = .horizontal
        Stack.spacing = ControlX(10)
        Stack.distribution = .equalSpacing
        Stack.alignment = .fill
        Stack.backgroundColor = .clear
        Stack.translatesAutoresizingMaskIntoConstraints = false
        Stack.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        return Stack
    }()
    
    lazy var DetailsTV : UITextView = {
        let TV = UITextView()
        TV.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        TV.isEditable = false
        TV.isSelectable = false
        TV.autocorrectionType = .no
        TV.backgroundColor = .clear
        TV.translatesAutoresizingMaskIntoConstraints = false
        TV.font = UIFont(name: "Poppins-Regular", size:  ControlWidth(18))
        TV.textContainerInset = UIEdgeInsets(top: 5, left: -4, bottom: 0, right: 0)
        return TV
    }()
    
    lazy var StackItems : UIStackView = {
        let Stack = UIStackView(arrangedSubviews: [TopStack,DetailsTV])
        Stack.axis = .vertical
        Stack.alignment = .fill
        Stack.spacing = ControlX(2)
        Stack.backgroundColor = .clear
        Stack.distribution = .equalSpacing
        Stack.translatesAutoresizingMaskIntoConstraints = false
        return Stack
    }()
    
    lazy var ImageBottom : UIImageView = {
        let ImageView = UIImageView()
        ImageView.clipsToBounds = true
        ImageView.backgroundColor = .clear
        ImageView.contentMode = .scaleAspectFill
        ImageView.image = UIImage(named: "Mask Group 48")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(StackItems)
        StackItems.topAnchor.constraint(equalTo: self.topAnchor,constant: ControlY(15)).isActive = true
        StackItems.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: ControlY(-15)).isActive = true
        StackItems.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: ControlX(15)).isActive = true
        StackItems.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: ControlX(-15)).isActive = true
        StackItems.arrangedSubviews[1].heightAnchor.constraint(equalTo: self.heightAnchor,constant: ControlY(-70)).isActive = true
        
        addSubview(ImageBottom)
        ImageBottom.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        ImageBottom.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        ImageBottom.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ImageBottom.heightAnchor.constraint(equalToConstant: ControlWidth(6)).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
