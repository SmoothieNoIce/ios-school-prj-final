//
//  GameRoomViewModel.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/12.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

enum CreateRoomResult:Error {
    case REPEAT_USER
    case MAX_ROOM
    case ERROR
}

enum FindRoomResult:String,Error {
    case NOT_FOUND = "未找到房間"
    
    var description: String {
            return self.rawValue
        }
}

class GameRoomViewModel: ObservableObject {
    @Published var gameRoom: GameRoom?
    private let store = Firestore.firestore()

    init() {
        fetchChanges()
    }
    
    func fetchChanges() {
        store.collection("rooms").document("\(gameRoom?.id)").addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else { return }
            guard let room = try? snapshot.data(as: GameRoom.self) else {return}
            self.gameRoom = room
        }
    }
    
    func modifyRoom(room: GameRoom) {
        do {
            try store.collection("rooms").document(room.id ?? "").setData(from: room)
        } catch  {
            print(error)
        }
    }
    
    func findRoomByInviteCode(invite_code:String,completion: @escaping (Result<GameRoom,FindRoomResult>) -> Void){
        store.collection("rooms").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let datas = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: GameRoom.self)
            }
            for data in datas{
                if data.invite_code == invite_code{
                    completion(.success(data))
                    return
                }
            }
            completion(.failure(.NOT_FOUND))
        }
    }
    
    func joinRoom(user:User,room:GameRoom){
        self.gameRoom = room
        fetchChanges()
        self.gameRoom?.room_members?.append(user.uid)
        self.modifyRoom(room: self.gameRoom!)
    }
    
    func leaveRoom(user:User){
        var list : [String] = self.gameRoom?.room_members ?? []
        list.removeAll{$0 == user.uid}
        self.gameRoom?.room_members = list
        self.modifyRoom(room: self.gameRoom!)
        self.gameRoom = nil
    }
    
    func removeRoom(){
        store.collection("rooms").document(gameRoom?.id ?? "").delete(completion: { error in
            
        })
        self.gameRoom = nil
    }
    
    func createRoom(user:User,completion: @escaping (Result<GameRoom,CreateRoomResult>) -> Void) -> Void {
        var invite_code =  String(Int.random(in: 1000..<10000))
        store.collection("rooms").getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let datas = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: GameRoom.self)
            }
            if datas.count == 9999{
                completion(.failure(.MAX_ROOM))
                return
            }
            if self.searchIsRepeatUser(datas: datas,user: user){
                //completion(.failure(.REPEAT_USER))
                //return
            }
            
        }
        do {
            var room = GameRoom(room_owner: user.uid, invite_code: invite_code, room_members: [], created_at: Date(), updated_at: Date())
            let documentReference = try store.collection("rooms").addDocument(from: room)
            room.id = documentReference.documentID
            self.gameRoom = room
            fetchChanges()
            completion(.success(room))
            return
        } catch  {
            completion(.failure(.ERROR))
            print(error)
            return
        }
    }

    func searchIsRepeatUser(datas:[GameRoom],user:User) -> Bool{
        for data in datas{
            if data.room_owner == user.uid{
                return true
            }
        }
        return false
    }


}
