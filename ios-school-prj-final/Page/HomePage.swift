//
//  HomePage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/4.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @Binding var currentPage : Page
    @Binding var isPresentUserInfo : Bool
    @State var name : String = "Flexolk"
    var body: some View {
        ZStack{
            Color(.systemPink).ignoresSafeArea()
            VStack{
                
                Text(name).font(.system(size: 40)).padding(90).colorInvert()
                Button(action: {
                    currentPage = Page.USER_INFO_PAGE
                }) {
                    HStack {
                        Text("玩家資訊")
                    }
                    .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                    .foregroundColor(.white)
                    .background(Color(.systemGreen))
                    .cornerRadius(10)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.sheet(isPresented: $isPresentUserInfo,onDismiss:{
                    currentPage = Page.HOME_PAGE
                }, content: {
                    UserInfoPage(currentPage:$currentPage)
                })
                Button(action: {
                    do {
                       try Auth.auth().signOut()
                        currentPage = Page.LOGIN_PAGE
                    } catch {
                       print(error)
                    }
                    
                }) {
                    HStack {
                        Text("登出")
                    }
                    .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                    .foregroundColor(.white)
                    .background(Color(.systemGreen))
                    .cornerRadius(10)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
        }.onAppear(perform: {
            if let user = Auth.auth().currentUser {
                name = String(user.displayName ?? "")
            } else {
                print("not login")
            }
        })
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(currentPage: .constant(Page.HOME_PAGE),isPresentUserInfo: .constant(false))
    }
}
