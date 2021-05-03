//
//  SignUpPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI
import FirebaseAuth

struct SignUpPage: View {
    @Binding var currentPage : Page
    @State var name:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var age:Float = 10
    var roles = ["無", "男生", "女生"]
    @State private var selectedIndex = 0
    var body: some View {
        VStack{
            Text("註冊").font(.system(size: 40)).padding(90)
            Button(action: {
                currentPage = Page.CHARACTER_SELECT_PAGE
            }) {
                HStack {
                    Text("選擇角色")
                }
                .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                .foregroundColor(.white)
                .background(Color(.systemPink))
                .cornerRadius(10)
                .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.padding()
            TextField("name", text: $name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextField("email", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextField("password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
           
            HStack{
                Text("年齡")
                Slider(value: $age, in: 0...100, step: 1)
                Text(String(Int(age)))
            }.padding(20).frame(width: 300, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            
      
            
            HStack{
                Picker(selection: $selectedIndex, label: Text("性別")) {
                   ForEach(roles.indices) { (index) in
                      Text(roles[index])
                   }
                }
            }.frame(width: 300,height: 120,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                
            }) {
                HStack {
                    Text("送出")
                }
                .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                .foregroundColor(.white)
                .background(Color(.systemPink))
                .cornerRadius(10)
                .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.padding()
            
        }
    }
}

func signUp(email:String,password:String){
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
        guard let user = result?.user,
              error == nil else {
            print(error?.localizedDescription)
            return
        }
        print(user.email, user.uid)
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage(currentPage: .constant(Page.SIGN_UP_PAGE))
    }
}
