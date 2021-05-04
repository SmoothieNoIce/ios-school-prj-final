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

struct UserInfoPage: View {
    @Binding var currentPage : Page
    @State var alertText:String = ""
    @State var uid:String = ""
    @State var name:String = ""
    @State var email:String = ""
    @State var characterImage : UIImage = UIImage()
    @State var money:String = ""
    @State var age:Int = 0
    @State var gender = Gender.None
    @State var created_at = Date()
    @State var updated_at = Date()

    var body: some View {
        VStack{
            Text("使用者資訊").font(.system(size: 40)).padding(40)
            Text(alertText).foregroundColor(.red)
            Image(uiImage: characterImage).resizable()
                .scaledToFit().frame(width: 70,height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("uid：\(uid)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 300.0, height: 60.0,alignment: .leading)
                .fixedSize()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            Text("名字：\(name)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 300.0, height: 60.0,alignment: .leading)
                .fixedSize()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            Text("Email：\(email)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 300.0, height: 60.0,alignment: .leading)
                .fixedSize()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            Text("Money：\(money)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 300.0, height: 60.0,alignment: .leading)
                .fixedSize()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            Text("Money：\(age)")
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .padding()
                .frame(width: 300.0, height: 60.0,alignment: .leading)
                .fixedSize()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        }.onAppear(perform: {
            if let user = Auth.auth().currentUser {
                uid = String(user.uid ?? "")
                name = String(user.displayName ?? "")
                email = String(user.email ?? "")
                let fileReference = Storage.storage().reference().child(user.photoURL?.path ?? "")
                            fileReference.getData(maxSize: 10 * 1024 * 1024) { result in
                                switch result {
                                case .success(let data):
                                    characterImage = UIImage(data: data)!
                                case .failure(let error):
                                    print(error)
                                }
                            }
            } else {
                print("not login")
            }
        })
        
    }
}

struct UserInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoPage(currentPage: .constant(Page.USER_INFO_PAGE))
    }
}
