//
//  LoginPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI

struct LoginPage: View {
    @State var email:String = ""
    @State var password:String = ""
    @Binding var currentPage : Page
    var body: some View {
        VStack{
            Text("登入").font(.system(size: 40)).padding(90)
            TextField("email", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextField("password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button(action: {
                currentPage = Page.SIGN_UP_PAGE
            }) {
                HStack {
                    Text("註冊")
                }
                .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                .foregroundColor(.white)
                .background(Color(.systemPink))
                .cornerRadius(10)
                .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(currentPage: .constant(Page.LOGIN_PAGE))
    }
}
