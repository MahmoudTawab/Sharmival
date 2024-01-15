//
//  MoreVC.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit

class MoreVC: ViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    var MoreColor = [#colorLiteral(red: 0.9530050159, green: 0.4710789323, blue: 0.1172198579, alpha: 1), #colorLiteral(red: 0.1578305066, green: 0.7085981369, blue: 0.8487736583, alpha: 1), #colorLiteral(red: 0.8034287095, green: 0.2209487557, blue: 0.4333723187, alpha: 1), #colorLiteral(red: 0.255530417, green: 0.6610907912, blue: 0.3418751955, alpha: 1), #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1)]
    var MoreImage = ["Transportation","Currency","Sponsors","FAQS","Gallery","Setting"]
    var MoreTitle = ["Transportation".localizable,"Sharmival Currency".localizable,"Sponsors".localizable,"FAQS".localizable,"Gallery".localizable,"Setting".localizable]
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpItem()
        view.backgroundColor = .white
    }
    
    fileprivate func SetUpItem() {
        SetUpButton()
        SetUpTopBarImage(60,false)
        view.addSubview(TopView)
        TopView.topAnchor.constraint(equalTo: TopBarImage.bottomAnchor, constant: ControlY(5)).isActive = true
        TopView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        TopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true
        
        view.addSubview(MoreLabel)
        MoreLabel.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        MoreLabel.topAnchor.constraint(equalTo: TopView.bottomAnchor, constant: ControlY(10)).isActive = true
        MoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: ControlX(15)).isActive = true
        MoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ControlX(-15)).isActive = true

        view.addSubview(MoreCollection)
        MoreCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        MoreCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        MoreCollection.topAnchor.constraint(equalTo: MoreLabel.bottomAnchor, constant: ControlY(10)).isActive = true
        MoreCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor ,constant: ControlHeight(-50)).isActive = true
    }


    lazy var MoreLabel : UILabel = {
        let Label = UILabel()
        let attributedString = NSMutableAttributedString(string: "Explore".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Light", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ])
        
        attributedString.append(NSAttributedString(string: "  ", attributes: [
            .foregroundColor: UIColor.clear
        ]))
        
        attributedString.append(NSAttributedString(string: "More".localizable, attributes: [
            .font: UIFont(name: "CocoGothic-Bold", size: ControlWidth(20)) ?? UIFont.systemFont(ofSize: ControlWidth(20)),
            .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]))
        
        Label.backgroundColor = .clear
        Label.attributedText = attributedString
        Label.translatesAutoresizingMaskIntoConstraints = false
        return Label
    }()
    

    let MoreID = "More"
    lazy var MoreCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let vc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vc.backgroundColor = .white
        vc.dataSource = self
        vc.delegate = self
        vc.showsHorizontalScrollIndicator = false
        vc.translatesAutoresizingMaskIntoConstraints = false
        vc.register(MoreCell.self, forCellWithReuseIdentifier: MoreID)
        vc.contentInset = UIEdgeInsets(top: 0, left: ControlX(10), bottom: ControlX(15), right: ControlX(10))
        return vc
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoreColor.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoreID, for: indexPath) as! MoreCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = ControlX(5)
        cell.backgroundColor = MoreColor[indexPath.item]
        cell.LabelTitle.text = MoreTitle[indexPath.item]
        cell.ImageView.image = UIImage(named: MoreImage[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2 ) - ControlX(16), height: ControlWidth(250))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            print("0")
        case 1:
        Present(ViewController: self, ToViewController: CurrencyVC())
        case 2:
            print("2")
        case 3:
        Present(ViewController: self, ToViewController: FAQSVC())
        case 4:
        Present(ViewController: self, ToViewController: AllGalleryVC())
        case 5:
        Present(ViewController: self, ToViewController: SettingVC())
        default:
        break
        }
    }
}
