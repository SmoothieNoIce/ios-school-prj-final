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
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                Image("Logo").resizable().scaledToFit().frame(width: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {
                    currentPage = Page.USER_INFO_PAGE
                }) {
                    HStack {
                        Text("Start").font(.custom("VCROSDMono", size: 18))
                    }
                    .padding()
                    .frame(width: 120.0, height: 45.0,alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
                }.sheet(isPresented: $isPresentUserInfo,onDismiss:{
                    currentPage = Page.HOME_PAGE
                }, content: {
                    UserInfoPage(currentPage:$currentPage)
                })
                Button(action: {
                    currentPage = Page.USER_INFO_PAGE
                }) {
                    HStack {
                        Text("Player Info").font(.custom("VCROSDMono", size: 18))
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
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
                        Text("Logout").font(.custom("VCROSDMono", size: 18))
                    }
                    .padding()
                    .frame(width: 120.0, height: 45.0,alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
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
