//
//  Faqs.swift
//  SHARMIVAL
//
//  Created by Emojiios on 14/09/2022.
//

import UIKit

class Faqs {

    var id : String?
    var q : String?
    var a : String?
    var FAQHidden = true
    var Color = UIColor()
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        q = dictionary["q"] as? String
        a = dictionary["a"] as? String
        Color = ColorGenerator.sharedInstance.next()
    }
}

class ColorGenerator {
    static let sharedInstance = ColorGenerator()
    private var last: UIColor
    private var colors : [UIColor] = [#colorLiteral(red: 0.9530050159, green: 0.4710789323, blue: 0.1172198579, alpha: 1), #colorLiteral(red: 0.1578305066, green: 0.7085981369, blue: 0.8487736583, alpha: 1), #colorLiteral(red: 0.8034287095, green: 0.2209487557, blue: 0.4333723187, alpha: 1), #colorLiteral(red: 0.255530417, green: 0.6610907912, blue: 0.3418751955, alpha: 1), #colorLiteral(red: 0.9608150125, green: 0.7241352201, blue: 0.1713911593, alpha: 1), #colorLiteral(red: 0.06250602752, green: 0.3065574765, blue: 0.5217253566, alpha: 1), #colorLiteral(red: 0.6171514392, green: 0.7769494653, blue: 0.9624547362, alpha: 1)]
    
    private init() {
        let random = Int(arc4random_uniform(UInt32(colors.count)))
        self.last = colors[random]
        colors.remove(at:random)
    }

    func next() -> UIColor {
        let random = Int(arc4random_uniform(UInt32(colors.count)))
        swap(&colors[random], &last)
        return last
    }
}
