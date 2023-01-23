//
//  ViewController.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 19/01/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var getOtpLbl: UILabel! {
        didSet{
            getOtpLbl.text = "Get OTP"
            getOtpLbl.textAlignment = .left
        }
    }
    @IBOutlet weak var enterPhoneNumberReqLbl: UILabel!
    @IBOutlet weak var countryCodeTxtFld: UITextField!{
        didSet{
            countryCodeTxtFld.keyboardType = .phonePad
        }
    }
    @IBOutlet weak var userPhoneTxtField: UITextField! {
        didSet{
            userPhoneTxtField.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var btnToGetOtp: customUIButton!
    private let ntwrkMngr = NetworkMngr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnToGetOtp.titleLabel?.text = "Continue"
        btnToGetOtp.layer.masksToBounds = true
        
    }
    
    
    
    @IBAction func getOtpBtnTapped(_ sender: UIButton) {
        guard let countryCode = countryCodeTxtFld.text else{return}
        guard let userPhone = userPhoneTxtField.text else {return}
        let entireNumber = countryCode+userPhone
        if entireNumber.isValidPhoneNumber{
            AppDelegate().showActivity(self.view, myTitle: "sending...")
            ntwrkMngr.getOtp(withNumber: entireNumber) {[weak self] Succeeded, ReceivedData in
                guard let self = self else {return}
                let loginConfirmation = ReceivedData["status"] as? Bool ?? false
                if Succeeded && loginConfirmation {
                defer {
                    AppDelegate().removeActivity(self.view)
                }
                    let TargetVC = self.storyboard?.instantiateViewController(withIdentifier: "OtpCheckerVC") as! OtpCheckerViewController
                    TargetVC.userNumber = entireNumber
                    self.navigationController?.pushViewController(TargetVC, animated: true)
                }else{
                    AppDelegate().removeActivity(self.view)
                    print("error occured. try later")
                }
            }
        }else{
        }
    }
}

// MARK: - TextField Properties

extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userPhoneTxtField{
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
        }
        return true
    }
}


