//
//  Utility.swift
//  RideCellTest
//
//  Created by Apple on 17/07/22.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
    
    func set(cornerRadius value:CGFloat, withBorder borderWidth:CGFloat, borderColor:UIColor) {
        self.layer.cornerRadius = value
        self.layer.borderWidth  = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.layoutIfNeeded()
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func roundedCorners(borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.cornerRadius = frame.height / 2
        self.layer.borderWidth  = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.layoutIfNeeded()
    }
    
}
