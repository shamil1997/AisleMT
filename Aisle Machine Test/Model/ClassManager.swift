//
//  ClassManager.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 20/01/23.
//

import Foundation


struct User : Decodable {
    var invites : Invites?
    var likes : UserLikes
}

struct UserLikes : Decodable {
    var can_see_profile : Bool
    var likes_received_count : Int
    var profiles : [UserLikesProfiles]?
}

struct UserLikesProfiles : Decodable {
    var avatar : String?
    var first_name : String?
}



struct Invites: Decodable {
    let pending_invitations_count: Int?
    let totalPages : Int
    let profiles: [Profile]
}

struct Profile: Decodable {
    let pending_invitations_count: Int
    let totalPages : Int
    let profiles : [profilesProfile]?

}
struct profilesProfile : Decodable{
    let general_information: GeneralInformation?
    let approved_time: Double
    let disapproved_time: Double
    let photos: [Photo]?
    let userInterests: [UserInterest]?
    let work: Work?
    let preferences: [Preference]?
    let profile_data_list : [UserInviteProfileDataList]?
}

struct GeneralInformation: Decodable {
    let dateOfBirth: String?
    let dateOfBirthV1: String?
    let location: Location?
    let drinkingV1: DrinkingV1?
    let firstName: String?
    let gender: String?
    let maritalStatusV1: MaritalStatusV1?
    let refID: String?
    let smokingV1: SmokingV1?
    let sunSignV1: SunSignV1?
    let motherTongue: MotherTongue?
    let faith: Faith?
    let height: Int?
    let cast: String?
    let kid: String?
    let diet: String?
    let politics: String?
    let pet: String?
    let settle: String?
    let mbti: String?
    let age: Int?
}

struct Location: Decodable {
    let summary: String?
    let full: String?
}

struct DrinkingV1: Decodable {
    let id: Int?
    let name: String?
    let nameAlias: String?
}

struct MaritalStatusV1: Decodable {
    let id: Int?
    let name: String?
    let preferenceOnly: Bool?
}

struct SmokingV1: Decodable {
    let id: Int?
    let name: String?
    let nameAlias: String?
}

struct SunSignV1: Decodable {
    let id: Int?
    let name: String?
}

struct MotherTongue: Decodable {
    let id: Int?
    let name: String?
}

struct Faith: Decodable {
    let id: Int?
    let name: String?
}

struct Photo: Decodable {
    let photo: String?
    let photoID: Int?
    let selected: Bool?
    let status: String?
}

struct UserInterest: Decodable {
    
}

struct Work: Decodable {
    let industryV1: IndustryV1?
    let monthlyIncomeV1: String?
    let experienceV1: ExperienceV1?
    let highestQualificationV1: HighestQualificationV1?
    let fieldOfStudyV1: FieldOfStudyV1?
}

struct IndustryV1: Decodable {
    let id: Int?
    let name: String?
    let preferenceOnly: Bool?
}

struct ExperienceV1: Decodable {
    let id: Int?
    let name: String?
    let nameAlias: String?
}

struct HighestQualificationV1: Decodable {
    let id: Int?
    let name: String?
    let preferenceOnly: Bool?
}

struct FieldOfStudyV1: Decodable {
let id: Int?
let name: String?
}

struct Preference: Decodable {
let answerID: Int?
let id: Int?
let value: Int?
let preferenceQuestion: PreferenceQuestion?
}

struct PreferenceQuestion: Decodable {
let firstChoice: String?
let secondChoice: String?
}












