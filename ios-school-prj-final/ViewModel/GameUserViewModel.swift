//
//  GameUserViewModel.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/13.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

enum GetUserResult:Error {
    case FAILED
}

class GameUserViewModel: ObservableObject {
    @Published var gameUser: GameUser?
    private let store = Firestore.firestore()

    init() {
        fetchChanges()
    }
    
    func fetchChanges() {
        store.collection("users").document("\(gameUser?.id)").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as: GameUser.self) else {return}
            self.gameUser = user
        }
    }
    
    func createUser(user:User,gameUser:GameUser) -> Bool {
        let db = Firestore.firestore()
                
        do {
            let documentReference = try db.collection("users").document(user.uid).setData(from: gameUser)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func getUser(user:User,completion: @escaping (Result<GameUser,GetUserResult>)-> Void) -> Void {
        let db = Firestore.firestore()
        
        db.collection("users").document(user.uid).getDocument(completion: { snapshot, error in
            if error != nil{
                completion(.failure(.FAILED))
            }
            guard let snapshot = snapshot else { return }
            let data = try? snapshot.data(as: GameUser.self)
            completion(.success(data!))
            
        })
    }

    func getUserByID(uid:String,completion: @escaping (Result<GameUser,GetUserResult>)-> Void) -> Void {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument(completion: { snapshot, error in
            if error != nil{
                completion(.failure(.FAILED))
            }
            guard let snapshot = snapshot else { return }
            let data = try? snapshot.data(as: GameUser.self)
            completion(.success(data!))
            
        })
    }

}

