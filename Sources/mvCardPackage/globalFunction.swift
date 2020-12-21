//
//  globalFunction.swift
//  UpRize
//
//  Created by vTech App Team on 2/7/20.
//  Copyright © 2020 Vtech Inc. All rights reserved.
//

import Foundation
import UIKit

public class globalFunction {
    public init() {}
    public static let sharedInstance = globalFunction()
    // convert to Dictionary
//    public func convertToDictionary(text: String) -> [String: Any]? {
//        if let data = text.data(using: .utf8) {
//            do {
//                return try JSONSerialization.jsonObject(with: data , options: []) as? [String: Any]
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        return nil
//    }

    public func convertDataString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let date = dateFormatter.date(from: dateString)

        dateFormatter.dateFormat = "MM/dd/yyyy" // this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }

    public func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "MM/dd/yyyy"
        let newDate = convertDateFormatter.date(from: inputDate)
        return convertDateFormatter.string(from: newDate!)
    }

//    func saveJSON(json: JSON, key: String) {
//        if let jsonString = json.rawString() {
//            UserDefaults.standard.setValue(jsonString, forKey: key)
//            UserDefaults.standard.synchronize()
//        }
//    }
//
//    func getJSON(_ key: String) -> JSON? {
//        var p = ""
//        if let result = UserDefaults.standard.string(forKey: key) {
//            p = result
//        }
//        if p != "" {
//            if let json = p.data(using: String.Encoding.utf8, allowLossyConversion: false) {
//                do {
//                    return try JSON(data: json)
//                } catch {
//                    return nil
//                }
//            } else {
//                return nil
//            }
//        } else {
//            return nil
//        }
//    }

    public func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: kUsernameKey) != nil
    }

    public func checkData(keyName: String) -> Bool {
        return UserDefaults.standard.object(forKey: keyName) == nil
    }

    public func shakeTextField(textField: UITextField, numberOfShakes: Int, direction: CGFloat, maxShakes: Int) {
        let interval: TimeInterval = 0.03
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        UIView.animate(withDuration: interval, animations: { () -> Void in
            textField.transform = CGAffineTransform(translationX: 5 * direction, y: 0)
        }, completion: { (_: Bool) -> Void in
            if numberOfShakes >= maxShakes {
                textField.transform = CGAffineTransform.identity
                return
            }
            self.shakeTextField(textField: textField, numberOfShakes: numberOfShakes + 1, direction: direction * -1, maxShakes: maxShakes)
        })
    }

    public func dropShadowCell(shadowView: UIView) {
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowView.layer.shadowRadius = 3
        shadowView.layer.backgroundColor = UIColor.white.cgColor
    }

//    func paddingShadowTxtField(field: UITextField) {
//        field.addShadowToTextField(color: UIColor.lightGray, cornerRadius: 10)
//        field.setPadding(left: 10, right: 5)
//        field.layer.backgroundColor = UIColor.white.cgColor
//    }

    public func remove_pref(remove_key: String) {
        UserDefaults.standard.removeObject(forKey: remove_key)
        UserDefaults.standard.synchronize()
    }

    public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    public func hideData(viewName: UIView, tblName: UITableView, strArray: [String]) {
        viewName.layer.backgroundColor = UIColor.white.cgColor
        if strArray.isEmpty == true {
            tblName.isHidden = true
            viewName.isHidden = false
        } else {
            tblName.isHidden = false
            viewName.isHidden = true
        }
    }
}
