//
//  UserInviteProfileDataLists.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 20/01/23.
//

import Foundation

struct UserInviteProfileDataList : Decodable {
    var invitation_type : String?
    var preferences : [UserInviteProfileDataListPreferences]?
    var question : String?
}

struct UserInviteProfileDataListPreferences: Decodable {
    var answer : String?
    var answer_id : Int?
    var first_choice : String?
    var second_choice : String?
}
