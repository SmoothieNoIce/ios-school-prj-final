//
//  AppController.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI
import FirebaseAuth

enum Page {
    case HOME_PAGE
    case LOGIN_PAGE
    case CHARACTER_SELECT_PAGE
    case SIGN_UP_PAGE
}


struct AppController: View {
    @State var currentPage = Page.LOGIN_PAGE
    @State var isPresentSignUp = false
    @State var isPresentCharacterSelect = false
    var body: some View {
        return ZStack{
            if currentPage == Page.LOGIN_PAGE || currentPage == Page.SIGN_UP_PAGE || currentPage == Page.CHARACTER_SELECT_PAGE{
                LoginPage(currentPage: $currentPage).sheet(isPresented: $isPresentSignUp,onDismiss:{
                    currentPage = Page.LOGIN_PAGE
                }, content: {
                    SignUpPage(currentPage:$currentPage).sheet(isPresented: $isPresentCharacterSelect,onDismiss:{
                        currentPage = Page.SIGN_UP_PAGE
                    }, content: {
                        CharacterSelectPage(currentPage:$currentPage)
                    })
                })
            }
        }.onAppear(perform: {
            if let user = Auth.auth().currentUser {
                print("\(user.uid) login")
            } else {
                currentPage = Page.LOGIN_PAGE
                print("not login")
            }
        }).onChange(of: currentPage, perform: { value in
            if value == Page.SIGN_UP_PAGE{
                isPresentSignUp = true
                isPresentCharacterSelect = false
            }else if value == Page.CHARACTER_SELECT_PAGE{
                isPresentSignUp = true
                isPresentCharacterSelect = true
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
