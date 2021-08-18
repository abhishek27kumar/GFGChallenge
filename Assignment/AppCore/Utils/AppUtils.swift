//
//  AppUtils.swift
//  Assignment
//
//  Created by Abhishek on 17/08/21.
//

import Foundation
import UIKit

struct AppUtils {
    
    static func isIphone() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return false
        }
        return true
    }
    
    static func showToast(msg: String, objectView: UIViewController) {
        objectView.view!.makeToast(message: msg, duration: HRToastDefaultDuration, position: HRToastPositionDefault as AnyObject)
    }
    
    static func showProgress(objectView: UIViewController) {
        objectView.view.isUserInteractionEnabled = false
        objectView.view!.makeToastActivity()
    }
    
    static func hideProgress(objectView: UIViewController) {
        DispatchQueue.main.async {
            objectView.view!.hideToastActivity()
            if !objectView.view.isUserInteractionEnabled {
                objectView.view.isUserInteractionEnabled = true
            }
        }
    }
 
    static func setViewRadius(view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
    }
    
    
    
    static func geAttributedText(mainStr: String, boldStr: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: mainStr)
        if mainStr.trimString().isEmpty {
            return attributedString
        }
        let font = UIFont.systemFont(ofSize: 14)//boldSystemFont(ofSize: 14)
        let color = UIColor.lightGray
       
        if let range = mainStr.lowercased().range(of: boldStr.lowercased()) {
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
            attributedString.setAttributes(attributes, range: NSRange( mainStr.range(of: mainStr)!, in: mainStr))
            
            let boldFont = UIFont.boldSystemFont(ofSize: 14)
           
            let attributeSearchStr = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: UIColor.darkGray]
            attributedString.addAttributes(attributeSearchStr, range: NSRange(range, in: mainStr))
        } else{
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color]
            attributedString.setAttributes(attributes, range: NSRange( mainStr.range(of: mainStr)!, in: mainStr))
        }
        return attributedString
    }
}


