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
                
                VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("玩家資訊").padding(18).font(.system(size: 17))
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
                                .fixedSize()
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
                            Text("名字：\(name)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("電子郵件：\(email)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("金錢：\(money)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("年齡：\(age)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("性別：\(gender)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("創建時間：\(created_at)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                            Text("創建時間：\(updated_at)")
                                .multilineTextAlignment(.leading)
                                .fixedSize()
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
                    let db = Firestore.firestore()
                    db.collection("users").whereField("uid", isEqualTo: "\(user.uid)").getDocuments { snapshot, error in
                        
                        guard let snapshot = snapshot else { return }
                        
                        let datas = snapshot.documents.compactMap { snapshot in
                            try? snapshot.data(as: GameUser.self)
                        }
                        money = datas[0].money
                        age = datas[0].age
                        switch datas[0].gender {
                        case Gender.None:
                            gender = "無"
                        case Gender.Male:
                            gender = "男性"
                        case Gender.Female:
                            gender = "女性"
                        }
                        created_at = datas[0].created_at ?? Date()
                        updated_at = datas[0].updated_at ?? Date()
                    }
                    
                    
                    
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
