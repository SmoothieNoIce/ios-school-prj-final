//
//  GameUser.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/13.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

enum Gender:Int,Codable{
    case None = 0
    case Male = 1
    case Female = 2
}

struct GameUser: Codable, Identifiable{
    @DocumentID var id: String?
    var name : String?
    var avatar : String?
    var email : String?
    var age : Int?
    var money : Int?
    var gender : Gender?
    var created_at : Date?
    var updated_at : Date?
}


class GameUser1: ObservableObject,Codable, Identifiable {
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decode(String.self, forKey: .uid)
        age = try container.decode(Int.self, forKey: .age)
        money = try container.decode(Int.self, forKey: .money)
        gender = try container.decode(Gender.self, forKey: .money)
        
        created_at = try container.decode(Date.self, forKey: .created_at)
        updated_at = try container.decode(Date.self, forKey: .updated_at)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uid, forKey: .uid)
        try container.encode(age, forKey: .age)
        try container.encode(money, forKey: .money)
        
        try container.encode(created_at, forKey: .created_at)
        try container.encode(updated_at, forKey: .updated_at)
    }
    
    @DocumentID var uid: String?
    @Published var age : Int = 0
    @Published var money : Int = 0
    @Published var gender : Gender
    @Published var created_at : Date?
    @Published var updated_at : Date?
    
    enum CodingKeys: CodingKey {
        case uid, age, money,gender, created_at, updated_at
    }
    
    init(uid:String,age:Int,money:Int,gender:Gender,created_at:Date,updated_at:Date){
        self.uid = uid
        self.age = age
        self.money = money
        self.gender = gender
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    func createUser() -> Bool {
        let db = Firestore.firestore()
        
        do {
            let documentReference = try db.collection("users").document(uid!).setData(from: self)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
}
