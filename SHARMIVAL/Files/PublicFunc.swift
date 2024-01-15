//
//  extension.swift
//  Volt (iOS)
//
//  Created by Emoji Technology on 23/07/2021.
//

import UIKit
import AVKit
import EventKit
import Foundation

func Present(ViewController:UIViewController,ToViewController:UIViewController) {
    let Controller = ToViewController
    Controller.hidesBottomBarWhenPushed = true
    Controller.modalPresentationStyle = .fullScreen
    Controller.modalTransitionStyle = .coverVertical
    ViewController.navigationController?.pushViewController(Controller, animated: true)
}


 func FirstController(_ Controller: UIViewController) {
     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
        let transition: CATransition = CATransition()
        appDelegate.window?.rootViewController?.navigationController?.popViewController(animated: true)
        appDelegate.window?.makeKeyAndVisible()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        appDelegate.window?.rootViewController?.view.window!.layer.add(transition, forKey: nil)
        let ControllerNav = UINavigationController(rootViewController: Controller)
        ControllerNav.navigationBar.isHidden = true
        appDelegate.window?.rootViewController = ControllerNav
        }
     }
 }

func topViewController(_ controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
if let navigationController = controller as? UINavigationController {
return topViewController(navigationController.visibleViewController)}
if let tabController = controller as? UITabBarController {
if let selected = tabController.selectedViewController {
return topViewController(selected)
}
}
if let presented = controller?.presentedViewController {
return topViewController(presented)
}
return controller
}


// UIDatePicker
public enum DateOrTime {
    case Date,Time
}

class RTLCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

extension UIDatePicker {
var textColor: UIColor? {
    set {
    setValue(newValue, forKeyPath: "textColor")
    setValue(false, forKey: "highlightsToday")
    }
    get {
    return value(forKeyPath: "textColor") as? UIColor
    }
  }
}

func AddRefreshControl(Scroll:UIScrollView , color: UIColor ,_ selector: @escaping () -> Void) {
let refreshControl = UIRefreshControl()
refreshControl.tintColor = color
refreshControl.addAction(for: .valueChanged) { (button) in
selector()
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
Scroll.refreshControl?.endRefreshing()}
}
Scroll.refreshControl = refreshControl
}


func DataAsArray<T: Encodable>(_ data: T) -> [[String:String]] {
  do {
  let encodedJSONData = try JSONEncoder().encode(data)
  if let Dictionary = try JSONSerialization.jsonObject(with: encodedJSONData, options: []) as? [[String:String]] {
  return Dictionary
  }
  } catch {
  print(error)
  }
  return []
}


 func DataAsAny<T: Encodable>(_ data: T) -> Any {
  do {
  let encodedJSONData = try JSONEncoder().encode(data)
  let Dictionary = try JSONSerialization.jsonObject(with: encodedJSONData, options: [])
  return Dictionary
  } catch {
  print(error)
  }
  return []
}
