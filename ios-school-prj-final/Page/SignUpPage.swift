//
//  SignUpPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct SignUpPage: View {
    
    @Binding var currentPage : Page
    @Binding var isPresentCharacterSelect : Bool
    @State var alertText:String = ""
    @State var name:String = ""
    @State var email:String = ""
    @State var password:String = ""
    @State var age:Float = 10
    @State var characterImage : UIImage = UIImage()
    var roles : [Gender] = [Gender.None, Gender.Male, Gender.Female]
    @State private var selectedIndex = 0
    
    var textView: some View {
        Text("Hello, SwiftUI")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
    
    
    var body: some View {
        VStack{
            Text("註冊").font(.system(size: 40)).padding(40)
            Text(alertText).foregroundColor(.red)
            Image(uiImage: characterImage).resizable()
                .scaledToFit().frame(width: 70,height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
            }.padding().sheet(isPresented: $isPresentCharacterSelect,onDismiss:{
                currentPage = Page.SIGN_UP_PAGE
            }, content: {
                CharacterSelectPage(characterImage: $characterImage, currentPage:$currentPage)
            })
            TextField("name", text: $name)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            TextField("email", text: $email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            SecureField("password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                .frame(width: 300, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            HStack{
                Text("年齡")
                Slider(value: $age, in: 0...100, step: 1)
                Text(String(Int(age)))
            }.padding(20).frame(width: 300, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            
            
            
            HStack(spacing: 20) {
                Picker(selection: $selectedIndex, label: Text("性別")) {
                    ForEach(roles.indices) { (index) in
                        switch(roles[index]){
                        case .None:
                            Text("無")
                        case .Male:
                            Text("男生")
                        case .Female:
                            Text("女生")
                        }
                    }
                }
            }.frame(width: 300,height: 50,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipped()
            
            Button(action: {
                alertText = ""
                uploadPhoto(image: characterImage) { result in
                    switch result {
                    case .success(let url):
                        signUp(imgUrl: url)
                    case .failure(let error):
                       print(error)
                    }
                }
               
            }) {
                HStack {
                    Text("送出")
                }
                .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                .foregroundColor(.white)
                .background(Color(.systemPink))
                .cornerRadius(10)
                .frame(width: 200, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.padding()
            
        }
    }
    
    func signUp(imgUrl:URL){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user,
                  error == nil else {
                print(error?.localizedDescription)
                alertText = error!.localizedDescription
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.photoURL = imgUrl
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { error in
               guard error == nil else {
                   print(error?.localizedDescription)
                    alertText = error!.localizedDescription
                   return
               }
            })
            var data : User = User(uid:user.uid,age: Int(age), money: 0, gender: roles[selectedIndex], created_at: Date(), updated_at: Date())
            data.createUser()
            print(user.email, user.uid)
            currentPage = Page.HOME_PAGE
        }
    }
}

func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".png")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                    fileReference.downloadURL { result in
                        switch result {
                        case .success(let url):
                            completion(.success(url))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}


struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage(currentPage: .constant(Page.SIGN_UP_PAGE),isPresentCharacterSelect: .constant(false))
    }
}
