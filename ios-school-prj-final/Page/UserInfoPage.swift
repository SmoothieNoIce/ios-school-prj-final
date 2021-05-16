//
//  UserInfoPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/4.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
import FirebaseFirestoreSwift
import Firebase
import Kingfisher


struct UserInfoPage: View {
    @Binding var currentPage : Page
    @State var gameUserViewModel = GameUserViewModel()
    @State var alertText:String = ""
    @State var uid:String = ""
    @State var name:String = ""
    @State var email:String = ""
    @State var characterImage : URL?
    @State var money:Int = 0
    @State var age:Int = 0
    @State var gender : String = ""
    @State var created_at = Date()
    @State var updated_at = Date()
    
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                
                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("PlayerInfo").padding(18).font(.custom("VCROSDMono", size: 18))
                    Spacer()
                    Button(action: {
                        currentPage = Page.HOME_PAGE
                    }) {
                        Image(systemName: "multiply").resizable().scaledToFit().frame(width: 18, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
                    }.foregroundColor(.black)
                }).frame(maxWidth: .infinity,alignment: .leading).background(Color(.white))
                
                
                ZStack{
                    KFImage(characterImage)
                        .resizable().scaledToFit().frame(width: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        )
                }.padding(40)
                
                Spacer()
                
                ScrollView{
                    VStack{
                        HStack{
                            Image(systemName: "grid").padding(.leading,20)
                            Text("uid：\(uid)")
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
                        
                        
                        HStack{
                            Image(systemName: "person.crop.circle").padding(.leading,20)
                            Text("Name：\(name)")
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
                        
                        HStack{
                            Image(systemName: "envelope").padding(.leading,20)
                            Text("Email：\(email)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "dollarsign.circle").padding(.leading,20)
                            Text("Money：\(money)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "figure.walk").padding(.leading,20)
                            Text("Age：\(age)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "face.smiling").padding(.leading,20)
                            Text("Gender：\(gender)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "clock").padding(.leading,20)
                            Text("Created：\(created_at)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                        
                        HStack{
                            Image(systemName: "clock").padding(.leading,20)
                            Text("Updated：\(updated_at)")
                                .multilineTextAlignment(.leading)
                                .fixedSize().font(.custom("VCROSDMono", size: 18))
                        }.padding(1)
                        .frame(width: 350.0, height: 50.0,alignment: .leading)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 7)
                        ).cornerRadius(10)
                    }
                }.padding()
                
                
            }.onAppear(perform: {
                if let user = Auth.auth().currentUser {
                    uid = String(user.uid ?? "")
                    name = String(user.displayName ?? "")
                    email = String(user.email ?? "")
                    characterImage = user.photoURL
                    
                    gameUserViewModel.getUser(user: user, completion: { res in
                        switch res {
                            case .success(let u):
                                money = u.money ?? 0
                                age = u.age ?? 0
                                let gen : Gender = u.gender ?? Gender.None
                                switch gen {
                                case Gender.None:
                                    gender = "None"
                                case Gender.Male:
                                    gender = "Male"
                                case Gender.Female:
                                    gender = "Female"
                                }
                                created_at = u.created_at ?? Date()
                                updated_at = u.updated_at ?? Date()
                            case .failure(let error):
                                print(error)
                            }
                    })
                    
                    
                } else {
                    print("not login")
                }
            })
        }
        
        
    }
}

struct UserInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoPage(currentPage: .constant(Page.USER_INFO_PAGE))
    }
}
