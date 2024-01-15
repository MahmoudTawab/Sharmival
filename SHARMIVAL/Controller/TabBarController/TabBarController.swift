//
//  TabBarController.swift
//  Bnkit
//
//  Created by Mahmoud Tawab on 9/6/20.
//  Copyright © 2020 Mahmoud Tawab. All rights reserved.
//

import UIKit
import FirebaseAuth

class TabBarController: UITabBarController, UITabBarControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        view.backgroundColor = .white
        SetUpController()
    }
    
    func SetUpController() {
        let Home = getController(root: HomeVC(), title: "Home".localizable, selectedImage: "SelectedHome", image: "Home")
        
        let Program = getController(root: ProgramVC(), title: "Program".localizable, selectedImage: "SelectedProgram", image: "Program")
        
        let Events = getController(root: EventsVC(), title: "Events".localizable, selectedImage: "SelectedEvents", image: "Events")
        
        let Map = getController(root: MapVC(), title: "Map".localizable, selectedImage: "SelectedMap", image: "Map")
        
        let More = getController(root: MoreVC(), title: "More".localizable, selectedImage: "SelectedMore", image: "More")
        
        viewControllers = [Home,Program,Events,Map,More]
    }
    
    func getController(root: UIViewController, title: String , selectedImage: String, image: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: root)
        controller.navigationBar.isHidden = true
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: image)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        controller.tabBarItem.setTitleTextAttributes([.font : UIFont(name: "Poppins-Regular", size: ControlWidth(12)) ?? UIFont.systemFont(ofSize: ControlWidth(12))], for: .normal)

        
        tabBar.tintColor = #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.clipsToBounds = true
        tabBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tabBar.layer.borderColor = UIColor.clear.cgColor
        return controller
    }
    
    init() {
    super.init(nibName: nil, bundle: nil)
    object_setClass(self.tabBar, WeiTabBar.self)
    }

    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}


class WeiTabBar: UITabBar {
      override func sizeThatFits(_ size: CGSize) -> CGSize {
          var sizeThatFits = super.sizeThatFits(size)
          
          if #available(iOS 11.0, *) {
          let bottomInset = safeAreaInsets.bottom
            sizeThatFits.height = bottomInset == 34.0 ? ControlHeight(65):ControlHeight(50)
          }else{
            sizeThatFits.height = ControlHeight(50)
          }
          
          self.clipsToBounds = false
          self.backgroundColor = .white
          self.layer.shadowColor = #colorLiteral(red: 0.7507388481, green: 0.7507388481, blue: 0.7507388481, alpha: 1).cgColor
          self.layer.shadowOffset = .zero
          self.layer.shadowOpacity = 0.6
          self.layer.shadowRadius = 6
          return sizeThatFits
      }
  }
