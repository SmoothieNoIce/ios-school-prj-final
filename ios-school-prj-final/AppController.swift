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
    case GAME_ROOM_PAGE
    case GAME_PAGE
}


struct AppController: View {
    @State var currentPage = Page.LOGIN_PAGE
    @State var isPresentSignUp = false
    @State var isPresentCharacterSelect = false
    @State var isPresentUserInfo = false
    @State var isPresentGameRoom = false

    var body: some View {
        return ZStack{
            if currentPage == Page.LOGIN_PAGE || currentPage == Page.SIGN_UP_PAGE || currentPage == Page.CHARACTER_SELECT_PAGE{
                LoginPage(currentPage: $currentPage).sheet(isPresented: $isPresentSignUp,onDismiss:{
                    currentPage = Page.LOGIN_PAGE
                }, content: {
                    SignUpPage(currentPage:$currentPage,isPresentCharacterSelect: $isPresentCharacterSelect)
                })
            }
            if currentPage == Page.HOME_PAGE || currentPage == Page.USER_INFO_PAGE || currentPage == Page.GAME_ROOM_PAGE{
                HomePage(currentPage: $currentPage,isPresentUserInfo:$isPresentUserInfo,isPresentGameRoom:$isPresentGameRoom)
            }
            if currentPage == Page.GAME_PAGE{
                GamePage(currentPage: $currentPage)
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
                isPresentGameRoom = false
            }else if value == Page.CHARACTER_SELECT_PAGE{
                isPresentSignUp = true
                isPresentCharacterSelect = true
                isPresentUserInfo = false
                isPresentGameRoom = false
            }else if value == Page.USER_INFO_PAGE{
                isPresentSignUp = false
                isPresentCharacterSelect = false
                isPresentUserInfo = true
                isPresentGameRoom = false
            }else if value == Page.HOME_PAGE{
                isPresentSignUp = false
                isPresentCharacterSelect = false
                isPresentUserInfo = false
                isPresentGameRoom = false
            }else if value == Page.GAME_ROOM_PAGE{
                isPresentSignUp = false
                isPresentCharacterSelect = false
                isPresentUserInfo = false
                isPresentGameRoom = true
            }else{
                isPresentSignUp = false
                isPresentCharacterSelect = false
                isPresentUserInfo = false
                isPresentGameRoom = false
            }
        })
    }
}

struct AppController_Previews: PreviewProvider {
    static var previews: some View {
        AppController()
    }
}
