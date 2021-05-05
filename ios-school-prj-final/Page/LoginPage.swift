//
//  LoginPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI
import FirebaseAuth

struct LoginPage: View {
    @State var email:String = ""
    @State var password:String = ""
    @State var alertText:String = ""
    @Binding var currentPage : Page
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("Logo").resizable().scaledToFit().frame(width: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(alertText).foregroundColor(.red)
                TextField("email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                SecureField("password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                    .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Button(action: {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                         guard error == nil else {
                            print(error?.localizedDescription)
                            alertText = error!.localizedDescription
                            return
                         }
                        print("ok")
                        currentPage = Page.HOME_PAGE
                    }
                }) {
                    HStack {
                        Text("登入")
                    }
                    .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Button(action: {
                    currentPage = Page.SIGN_UP_PAGE
                }) {
                    HStack {
                        Text("註冊")
                    }
                    .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 5)
                    )
                    .cornerRadius(10)
                    .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
        }
     
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(currentPage: .constant(Page.LOGIN_PAGE))
    }
}
