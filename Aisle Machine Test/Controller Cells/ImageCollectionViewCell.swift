//
//  ImageCollectionViewCell.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 20/01/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = userProfileImage.frame
        userProfileImage.addSubview(blurView)
    }
    
    
    
    
    
    
}
