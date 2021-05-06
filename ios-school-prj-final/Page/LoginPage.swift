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
    @State var showAlert = false
    @Binding var currentPage : Page
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Image("Logo").resizable().scaledToFit().frame(width: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text(alertText).foregroundColor(.red)
                HStack{
                    Text("Email:").padding(.leading,14).font(.custom("VCROSDMono", size: 18))
                    TextField("email", text: $email)
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
                HStack{
                    Text("Password:").padding(.leading,14).font(.custom("VCROSDMono", size: 18))
                    SecureField("password", text: $password)
                        .padding(.leading,5)
                        .foregroundColor(.white)
                }.padding(1)
                .frame(width: 300.0, height: 50.0,alignment: .leading)
                .foregroundColor(.white)
                .background(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 7)
                ).cornerRadius(10)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
                    Button(action: {
                        Auth.auth().signIn(withEmail: email, password: password) { result, error in
                             guard error == nil else {
                                print(error?.localizedDescription)
                                alertText = error!.localizedDescription
                                showAlert = true
                                return
                             }
                            print("ok")
                            currentPage = Page.HOME_PAGE
                        }
                    }) {
                        HStack {
                            Text("Login").font(.custom("VCROSDMono", size: 18))
                        }
                        .padding(.trailing,24).padding(.leading,24).padding(.top,10).padding(.bottom,10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 5)
                        )
                        .cornerRadius(10)
                    }.alert(isPresented: $showAlert) { () -> Alert in
                        return Alert(title: Text(alertText))
                     }

                    Button(action: {
                        currentPage = Page.SIGN_UP_PAGE
                    }) {
                        HStack {
                            Text("Sign up").font(.custom("VCROSDMono", size: 18))
                        }
                        .padding(.trailing,24).padding(.leading,24).padding(.top,10).padding(.bottom,10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 5)
                        )
                        .cornerRadius(10)
                    }
                }).padding(20)
            }
        }
     
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(currentPage: .constant(Page.LOGIN_PAGE))
    }
}
