//
//  ShowAlerts.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 20/01/23.
//

import Foundation
import UIKit

class ShowAlerts : NSObject {
    var mainView = UIView()
    var alertVC = UIAlertController()
    let activityIndicator = UIActivityIndicatorView()
    @objc var loadingView: UIView = UIView()
    @objc var actView: UIView = UIView()
    @objc var titleLabel: UILabel = UILabel()
    
    @objc func showNormalActivity(_ myView: UIView, myTitle: String) {
        var newString = myTitle
        if myTitle == "Loading"{
            newString = "Loading..."
        }
        myView.isUserInteractionEnabled = false
        myView.window?.isUserInteractionEnabled = false
        myView.endEditing(true)
        let heightForActivity : CGFloat  = getHeightForActivity(Count: myTitle.count)
        let widthForActivity : CGFloat  = getWidthForActivity(Count: myTitle.count)
        let subviewForActivity = UIView()
        
        actView.frame = CGRect(x: 0, y: 0, width: myView.frame.width, height: myView.frame.height)
        actView.center = myView.center
        actView.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: widthForActivity, height: heightForActivity)
        loadingView.center = myView.center
        loadingView.backgroundColor = .blue
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius =  loadingView.frame.height / 2
        subviewForActivity.frame =  CGRect(x: 0.0, y: 0.0, width: heightForActivity, height: heightForActivity)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: subviewForActivity.frame.height * 0.8, height: subviewForActivity.frame.height * 0.8)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.center = CGPoint(x: subviewForActivity.frame.width / 2  , y: subviewForActivity.frame.size.height / 2)
        activityIndicator.startAnimating()
        titleLabel.frame = CGRect(x: subviewForActivity.frame.width - 5, y: 0, width: loadingView.frame.width - subviewForActivity.frame.width  - 5 , height: subviewForActivity.frame.size.height)
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = newString
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = UIColor.clear
        subviewForActivity.backgroundColor = UIColor.clear
        subviewForActivity.addSubview(activityIndicator)
        
        loadingView.addSubview(titleLabel)
        loadingView.addSubview(subviewForActivity)
        actView.addSubview(loadingView)
        myView.addSubview(actView)
        
    }
    func getHeightForActivity(Count : Int)-> CGFloat{
        var height  = CGFloat()
        print(Count)
        let normal_Height = UIScreen.main.bounds.size.height * 0.06
        let avg_Height = UIScreen.main.bounds.size.height * 0.08
        let max_Height =  UIScreen.main.bounds.size.height
        if Count >= 30 && Count < 50{
            height = avg_Height
        }else if Count > 0 && Count < 30{
            height = normal_Height
        }else   if Count >= 50 {
            height = max_Height
        }
        return height
    }
    func getWidthForActivity(Count : Int)-> CGFloat{
        var Width  = CGFloat()
        print(Count)
        let normal_Width =  UIScreen.main.bounds.size.width * 0.42
        let avg_Width = UIScreen.main.bounds.size.width * 0.6
        let max_Width =  UIScreen.main.bounds.size.width * 0.7
       
        if Count >= 30 && Count < 50{
            Width = avg_Width
        }else if Count > 0 && Count < 30{
            Width = normal_Width
        }else   if Count >= 50 {
            Width = max_Width
        }
        return Width
    }
    @objc func removeActivity(_ myView: UIView) {
        myView.isUserInteractionEnabled = true
        myView.window?.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        loadingView.removeFromSuperview()
        actView.removeFromSuperview()
    }
}
