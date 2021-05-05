//
//  AppController.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

enum Page {
    case HOME_PAGE
    case LOGIN_PAGE
    case CHARACTER_SELECT_PAGE
    case SIGN_UP_PAGE
    case USER_INFO_PAGE
}

enum Gender:Int,Decodable{
    case None = 0
    case Male = 1
    case Female = 2
}

class GameUser: ObservableObject,Codable, Identifiable {
    
    
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

struct AppController: View {
    @State var currentPage = Page.LOGIN_PAGE
    @State var isPresentSignUp = false
    @State var isPresentCharacterSelect = false
    @State var isPresentUserInfo = false
    var body: some View {
        return ZStack{
            if currentPage == Page.LOGIN_PAGE || currentPage == Page.SIGN_UP_PAGE || currentPage == Page.CHARACTER_SELECT_PAGE{
                LoginPage(currentPage: $currentPage).sheet(isPresented: $isPresentSignUp,onDismiss:{
                    currentPage = Page.LOGIN_PAGE
                }, content: {
                    SignUpPage(currentPage:$currentPage,isPresentCharacterSelect: $isPresentCharacterSelect)
                })
            }
            if currentPage == Page.HOME_PAGE || currentPage == Page.USER_INFO_PAGE{
                HomePage(currentPage: $currentPage,isPresentUserInfo:$isPresentUserInfo)
            }
        }.onAppear(perform: {
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
                currentPage = Page.HOME_PAGE
            } else {
                currentPage = Page.LOGIN_PAGE
                print("not login")
            }
        }).onChange(of: currentPage, perform: { value in
            if value == Page.SIGN_UP_PAGE{
                isPresentSignUp = true
                isPresentCharacterSelect = false
                isPresentUserInfo = false
            }else if value == Page.CHARACTER_SELECT_PAGE{
                isPresentSignUp = true
                isPresentCharacterSelect = true
                isPresentUserInfo = false
            }else if value == Page.USER_INFO_PAGE{
                isPresentSignUp = false
                isPresentCharacterSelect = false
                isPresentUserInfo = true
            }else{
                isPresentSignUp = false
                isPresentCharacterSelect = false
            }
        })
    }
}

struct AppController_Previews: PreviewProvider {
    static var previews: some View {
        AppController()
    }
}
