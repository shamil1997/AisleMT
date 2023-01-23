//
//  NetworkManager.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 19/01/23.
//

import Foundation
import UIKit


class NetworkMngr {
    private let BaseUrl = "https://testa2.aisle.co/V1"
    private let loginEndPoint = "/users/phone_number_login"
    private let otpEndPoint = "/users/verify_otp"
    private let notesEndPoint = "/users/test_profile_list"
    
    func setUpInitialOTPsendingAndVerification(withUrlString urlString : String, withNumber number : String, postCompleted : @escaping (_ Succeeded : Bool, _ ReceivedData : NSDictionary)-> ()){
        
    }
    
    
    func getOtp(withNumber number : String, postCompleted : @escaping (_ Succeeded : Bool, _ ReceivedData : NSDictionary)-> ()) {
        if let otpUrl = URL(string: "\(BaseUrl)\(loginEndPoint)") {
            var reqUrl = URLRequest(url: otpUrl)
            let session = URLSession.shared
            reqUrl.httpMethod = "POST"
            let params = ["number" : number]
            do {
                reqUrl.httpBody = try! JSONSerialization.data(withJSONObject: params)
            }
            reqUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
            reqUrl.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: reqUrl) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        do {
                            guard let jsonReturned = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {return}
                            postCompleted(true, jsonReturned)
                        }catch let error as NSError{
                            print(error.localizedDescription)
                            postCompleted(false, [:])
                        }
                    }
                }
            }
            task.resume()
        }else{
            print("unexpected error occured")
        }
        
        
    }
    
    
    func verifyOtp(withphoneNumber number : String, withOtp otp : String, postCompleted : @escaping (_ Succeeded : Bool, _ ReceivedData : NSDictionary)-> ()) {
        if let otpVerificationUrl = URL(string: "\(BaseUrl)\(otpEndPoint)") {
            var verificationReq = URLRequest(url: otpVerificationUrl)
            let session = URLSession.shared
            verificationReq.httpMethod = "POST"
            let params = ["number" : number, "otp" : otp]
            do {
                verificationReq.httpBody = try! JSONSerialization.data(withJSONObject: params)
            }
            verificationReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            verificationReq.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: verificationReq) { data, response, error in
                DispatchQueue.main.async {
                    if let receivedData = data{
                        do {
                            guard let jsonReturned = try JSONSerialization.jsonObject(with: receivedData) as? NSDictionary else {return}
                            postCompleted(true, jsonReturned)
                        }catch let error as NSError {
                            print(error.localizedDescription)
                            postCompleted(false,[:])
                        }
                    }
                }
            }
            task.resume()
        }else{
            print("unexpected error")
        }
    }
    
    func getUserHomeScreen(withUserToken token : String, postCompleted : @escaping (_ Succeeded : Bool, _ ReceivedData : User?)-> ()) {
        if let getUserScreenDetailsUrl = URL(string: "\(BaseUrl)\(notesEndPoint)") {
            var getUserProfilesReq = URLRequest(url: getUserScreenDetailsUrl)
            let session = URLSession.shared
            getUserProfilesReq.addValue(token, forHTTPHeaderField: "Authorization")
            getUserProfilesReq.httpMethod = "GET"
            getUserProfilesReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            getUserProfilesReq.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: getUserProfilesReq) { data, response, error in
                if let err = error{
                    print("error")
                    postCompleted(false, nil)
                }
                if let dataReceived = data{
                    do {
                        guard let retrnedData = try JSONSerialization.jsonObject(with: dataReceived) as? NSDictionary else {return}
                        print(retrnedData)
                        let decodedData = try JSONDecoder().decode(User.self, from: dataReceived)
                        print(decodedData)
                        postCompleted(true, decodedData)
                    }catch let error as NSError {
                        print(error.localizedDescription)
                        postCompleted(false, nil)
                    }
                }
            }
            task.resume()
            
        }
    }
    
    
}




