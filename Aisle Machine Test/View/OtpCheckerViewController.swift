//
//  OtpCheckerViewController.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 19/01/23.
//

import UIKit

class OtpCheckerViewController: UIViewController {
    
    @IBOutlet weak var userPhoneNumber: UILabel!
    @IBOutlet weak var EnterOTPPrompt: UILabel!
    @IBOutlet weak var enterOtpTextField: UITextField!{
        didSet{
            enterOtpTextField.keyboardType = .numberPad
        }
    }
    @IBOutlet weak var continueBtn: customUIButton!
    @IBOutlet weak var countDownTimerLbl: UILabel!
    
    var userNumber = ""
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    private var networkMngr = NetworkMngr()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        userPhoneNumber.text = userNumber
        continueBtn.addTarget(self, action: #selector(VerifyOtpBtn(_:)), for: .touchUpInside)
        runTimer()
        // Do any additional setup after loading the view.
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            countDownTimerLbl.text = "send OTP again"
            countDownTimerLbl.isUserInteractionEnabled = true
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(timerLabelTapped(_ :)))
            tapgesture.numberOfTapsRequired = 1
            self.countDownTimerLbl.addGestureRecognizer(tapgesture)
        }else{
            seconds -= 1
            countDownTimerLbl.text = "00:\(seconds)"
        }
    }
    
    @objc func timerLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let text = self.countDownTimerLbl.text else { return }
        if text == "send OTP again" {
            getOTPAgain()
        }
    }
    
    func getOTPAgain() {
        AppDelegate().showActivity(self.view, myTitle: "Re sending the OTP...")
        networkMngr.getOtp(withNumber: userNumber) { Succeeded, ReceivedData in
            let otpSentConfirm = ReceivedData["status"] as? Bool ?? false
            if Succeeded && otpSentConfirm {
                AppDelegate().removeActivity((self.view)!)
                self.seconds = 59
                self.countDownTimerLbl.text = "00:\(self.seconds)"
                self.runTimer()
            }
        }
    }
    @objc func VerifyOtpBtn(_ sender:UIButton) {
        guard let otpToEnter = enterOtpTextField.text else {return}
        AppDelegate().showActivity(self.view, myTitle: "Validating...")
        networkMngr.verifyOtp(withphoneNumber: userNumber, withOtp: otpToEnter) {[weak self] Succeeded, ReceivedData in
            guard let self = self else {return}
            let userAuthenticationToken = ReceivedData["token"] as? String ?? ""
            if Succeeded && userAuthenticationToken != "" {
                defer {
                    AppDelegate().removeActivity(self.view)
                }
                let TargetVC = self.storyboard?.instantiateViewController(withIdentifier: "seeLoggedINUser") as! UITabBarController
                let destinationVC = TargetVC.viewControllers?[0] as! HomeScreenViewController
                destinationVC.userToken = userAuthenticationToken
                self.navigationController?.pushViewController(destinationVC, animated: true)
            }else{
                print("invalid OTP")
                AppDelegate().removeActivity(self.view)
            }
        }
    }
}
extension OtpCheckerViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 4
    }
}
