//
//  CustomMarkerView.swift
//  CustomMarker
//
//  Created by Sai Sandeep on 11/12/19.
//  Copyright © 2019 Sai Sandeep. All rights reserved.
//

import UIKit
import SDWebImage

class CustomMarkerView: UIView {

    var imageName: String?
    init(frame: CGRect, imageName: String?, tag: Int) {
        super.init(frame: frame)
        self.imageName=imageName
        self.tag = tag
        setupViews()
    }
    
    func setupViews() {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imgView)
        imgView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        imgView.contentMode = .scaleAspectFit
        imgView.sd_setImage(with: URL(string: imageName ?? ""), placeholderImage: UIImage(named: "Map-Marker"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
