//
//  HomeScreenViewController.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 19/01/23.
//

import UIKit
import SDWebImage

class HomeScreenViewController: UIViewController {
    
    var pictures = [String : Any]()
    var userToken = ""
    var netWorkManager = NetworkMngr()
    var testDict = NSDictionary()
    var gradientLayer = CAGradientLayer()
    var retreivedJson : User?
    

    @IBOutlet weak var ProfilePageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        getHomeScreenData()
        
        ProfilePageCollectionView.collectionViewLayout = createLayout()
        // Do any additional setup after loading the view.
    }
    
    func getHomeScreenData () {
        if userToken != "" {
            netWorkManager.getUserHomeScreen(withUserToken: userToken) { Succeeded, ReceivedData in
                if Succeeded{
                    self.retreivedJson = ReceivedData
                    DispatchQueue.main.async {
                        self.ProfilePageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75),
                                                                             heightDimension: .fractionalHeight(0.75)))
         item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)

         let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                           heightDimension: .fractionalWidth(1.0)), subitems: [item])

        let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                                              heightDimension: .fractionalHeight(1/2)))
         item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 1)
         let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5),
                                                                               heightDimension: .fractionalHeight(1/3)))
         item2.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 1, bottom: 10, trailing: 1)

        let group2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1/3)), subitems: [item1, item2])

         let section = NSCollectionLayoutSection(group: group)
         section.orthogonalScrollingBehavior = .groupPaging
//         section.boundarySupplementaryItems = [header]
         section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
         section.interGroupSpacing = 1
         section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
         return UICollectionViewCompositionalLayout(section: section)
    }

}

extension HomeScreenViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            return retreivedJson?.invites?.profiles.count ?? 1
        }else if section == 1{
            return retreivedJson?.likes.likes_received_count ?? 1
        }
        return testDict.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return retreivedJson.debugDescription.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagePersonalisationCell", for: indexPath) as!ImageCollectionViewCell
        cell.userProfileImage.layer.cornerRadius = 20
        cell.userProfileImage.layer.borderColor = UIColor.black.cgColor
        cell.userProfileImage.layer.borderWidth = 0.5
        cell.userProfileImage.clipsToBounds = true
        cell.userProfileImage.contentMode = .scaleAspectFill
        if indexPath.section == 0 {
            let retreivdimageData = retreivedJson?.invites?.profiles[indexPath.row]
            let retreivedUserPrfile = retreivdimageData?.profiles?[indexPath.row]
            let singleUserData = retreivedUserPrfile?.photos?[indexPath.row]
            cell.userNameLbl.text = " \(retreivedUserPrfile?.general_information?.firstName ?? "")"
            guard let imageUrl = singleUserData?.photo as? String else {return cell}
            cell.userProfileImage.sd_setImage(with: URL(string: imageUrl))
            return cell
        }else if indexPath.section == 1{
            let retreivedImageProfiles = retreivedJson?.likes.profiles?[indexPath.row]
            guard let imageUrl = retreivedImageProfiles?.avatar as? String else {return cell}
            cell.userNameLbl.text = retreivedImageProfiles?.first_name as? String ?? ""
            guard let isUserPremium = retreivedJson?.likes.can_see_profile as? Bool else {return cell}
            if isUserPremium{

            }else{
                cell.addBlurEffect()
            }
            cell.userProfileImage.sd_setImage(with: URL(string: imageUrl))
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeaderReusableViewCollectionReusableView", for: indexPath) as! CollectionViewHeaderReusableViewCollectionReusableView
        
        if indexPath.section == 0 {
            headerView.mainHeaderLbl.text =  "Notes"
            headerView.subHeaderLbl.text = "personal messages to you"
            headerView.mainHeaderLbl.textAlignment = .center
            headerView.subHeaderLbl.textAlignment = .center
            headerView.ActivatePremiumBtn.isHidden = true
            return headerView
        }else{
            headerView.mainHeaderLbl.text =  "Interested in you"
            headerView.subHeaderLbl.text = "premium members can view their likes at once"
            headerView.mainHeaderLbl.font = UIFont.boldSystemFont(ofSize: 17)
            headerView.subHeaderLbl.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
            headerView.mainHeaderLbl.textAlignment = .left
            headerView.subHeaderLbl.textAlignment = .left
            headerView.ActivatePremiumBtn.isHidden = false
            headerView.ActivatePremiumBtn.setTitle("Upgrade", for: .normal)
            return headerView
        }
        
    }
    
    
}

