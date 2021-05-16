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
    @Binding var isPresentGameRoom : Bool
    @State var name : String = "Flexolk"
    @State var inviteCode : String = ""
    @StateObject var roomViewModel = GameRoomViewModel()
    @State var showAlert = false
    @State var alertText:String = ""
    @State var createNewRoom:Bool = true
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                Image("Logo").resizable().scaledToFit().frame(width: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
                HStack{
                    Text("Invite code:").padding(.leading,20).font(.custom("VCROSDMono", size: 18))
                    TextField("name", text: $inviteCode)
                        .padding(.leading,5)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                }.padding(1)
                .frame(width: 300.0, height: 50.0,alignment: .leading)
                .foregroundColor(.white)
                .background(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 7)
                ).cornerRadius(10)
                
                Button(action: {
                    roomViewModel.findRoomByInviteCode(invite_code:inviteCode,completion: { res in
                        switch res{
                        case .success(let room):
                            if let user = Auth.auth().currentUser {
                                createNewRoom = false
                                roomViewModel.joinRoom(user: user, room: room)
                                currentPage = Page.GAME_ROOM_PAGE
                            } else {
                                print("not login")
                            }
                        case .failure(let error):
                            showAlert = true
                            alertText = error.description
                        }
                    })
                }) {
                    HStack {
                        Text("Join room").font(.custom("VCROSDMono", size: 18))
                    }
                    .padding()
                    .frame( height: 45.0,alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
                }
                
                Button(action: {
                    currentPage = Page.GAME_ROOM_PAGE
                    createNewRoom = true
                }) {
                    HStack {
                        Text("Create room").font(.custom("VCROSDMono", size: 18))
                    }
                    .padding()
                    .frame(height: 45.0,alignment: .center)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
                }.sheet(isPresented: $isPresentGameRoom,onDismiss:{
                    currentPage = Page.HOME_PAGE
                }, content: {
                    GameRoomPage(currentPage: $currentPage,createNewRoom: $createNewRoom,roomViewModel:roomViewModel)
                }).alert(isPresented: $showAlert) { () -> Alert in
                    return Alert(title: Text(alertText))
                 }
                
             
                
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
        HomePage(currentPage: .constant(Page.HOME_PAGE),isPresentUserInfo: .constant(false),isPresentGameRoom: .constant(false))
    }
}
