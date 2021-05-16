//
//  GameRoomPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/7.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

struct GameRoomPage: View {
    @Binding var currentPage : Page
    @Binding var createNewRoom:Bool
    @ObservedObject var roomViewModel = GameRoomViewModel()
    
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("Game Room").padding(18).font(.custom("VCROSDMono", size: 18))
                    Spacer()
                    Button(action: {
                        currentPage = Page.HOME_PAGE
                    }) {
                        Image(systemName: "multiply").resizable().scaledToFit().frame(width: 18, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
                    }.foregroundColor(.black)
                }).frame(maxWidth: .infinity,alignment: .leading).background(Color(.white))
                
                Spacer()
               
                HStack{
                    Image(systemName: "grid").padding(.leading,20)
                    Text("Invite code:\(roomViewModel.gameRoom?.invite_code ?? "")")
                        .multilineTextAlignment(.leading)
                        .fixedSize().font(.custom("VCROSDMono", size: 18))
                }
                .padding(1)
                .frame(width: 350.0, height: 50.0,alignment: .leading)
                .foregroundColor(.white)
                .background(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 7)
                ).cornerRadius(10)
                
                ForEach(roomViewModel.gameRoom?.room_members?.indices ?? [].indices, id:\.self){index in
                    HStack{
                        Image(systemName: "grid").padding(.leading,20)
                        Text("\(roomViewModel.gameRoom?.room_members?[index] ?? "")")
                            .multilineTextAlignment(.leading)
                            .fixedSize().font(.custom("VCROSDMono", size: 18))
                    }
                    .padding(1)
                    .frame(width: 350.0, height: 50.0,alignment: .leading)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 7)
                    ).cornerRadius(10)
                }

                Spacer()
            })
        }.onAppear(perform: {
            if createNewRoom{
                if let user = Auth.auth().currentUser {
                    roomViewModel.createRoom(user: user, completion: { result in
                        switch result {
                            case .success(let room):
                                print(room.id)
                            case .failure(let error):
                                print(error)
                            }
                    })
                    
                }
            }else{
                
            }
        }).onDisappear(perform: {
            if createNewRoom{
                roomViewModel.removeRoom()
            }else{
                if let user = Auth.auth().currentUser {
                    roomViewModel.leaveRoom(user: user)
                }
            }
        })
    }
}

struct GameRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        GameRoomPage(currentPage: .constant(Page.GAME_ROOM_PAGE),createNewRoom:.constant(true),roomViewModel: GameRoomViewModel())
    }
}
