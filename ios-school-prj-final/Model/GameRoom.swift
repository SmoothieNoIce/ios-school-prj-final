//
//  GameRoom.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/12.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

struct GameRoom: Codable, Identifiable{
    @DocumentID var id: String?
    var room_owner : String?
    var invite_code : String?
    var room_members : [String]?
    var created_at : Date?
    var updated_at : Date?
}

