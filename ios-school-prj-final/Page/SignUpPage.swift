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
    @State var characterImage : UIImage = UIImage(named: "BASE") ?? UIImage()
    var roles : [Gender] = [Gender.None, Gender.Male, Gender.Female]
    @State private var selectedIndex = 0
    
    @StateObject var gameUserViewModel = GameUserViewModel()
    
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack(alignment: .center, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("Sign up").padding(18).font(.custom("VCROSDMono", size: 18))
                    Spacer()
                    Button(action: {
                        currentPage = Page.LOGIN_PAGE
                    }) {
                        Image(systemName: "multiply").resizable().scaledToFit().frame(width: 18, height: 18, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).padding()
                    }.foregroundColor(.black)
                }).frame(maxWidth: .infinity,alignment: .leading).background(Color(.white))
                                       
                Spacer()
                
                VStack{
                    Text("New Crewmate").font(.custom("VCROSDMono", size: 30)).colorInvert()
                    Text(alertText).foregroundColor(.red)
                    Image(uiImage: characterImage).resizable()
                        .scaledToFit().frame(width: 200,height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        currentPage = Page.CHARACTER_SELECT_PAGE
                    }) {
                        HStack {
                            Text("Select Character").font(.custom("VCROSDMono", size: 14))
                        }
                        .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 5)
                        )
                        .cornerRadius(10)
                        .frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.padding().sheet(isPresented: $isPresentCharacterSelect,onDismiss:{
                        currentPage = Page.SIGN_UP_PAGE
                    }, content: {
                        CharacterSelectPage(characterImage: $characterImage, currentPage:$currentPage)
                    })
                    HStack{
                        Text("Name:").padding(.leading,20).font(.custom("VCROSDMono", size: 18))
                        TextField("name", text: $name)
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
                    
                    HStack{
                        Text("Email:").padding(.leading,20).font(.custom("VCROSDMono", size: 18))
                        TextField("name", text: $email)
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
                        Text("Password:").padding(.leading,20).font(.custom("VCROSDMono", size: 18))
                        SecureField("password", text: $password)
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
                        Text("Age").font(.custom("VCROSDMono", size: 18)).colorInvert()
                        Slider(value: $age, in: 0...100, step: 1)
                        Text(String(Int(age))).font(.custom("VCROSDMono", size: 18)).colorInvert()
                    }.padding(20).frame(width: 300, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    
                    
                    
                    HStack(spacing: 20) {
                        Picker(selection: $selectedIndex, label: Text("性別")) {
                            ForEach(roles.indices) { (index) in
                                switch(roles[index]){
                                case .None:
                                    Text("Nome")
                                case .Male:
                                    Text("Male")
                                case .Female:
                                    Text("Female")
                                }
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }.background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6))).frame(width: 300,height: 50,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipped()
                    
                    Button(action: {
                        alertText = ""
                        if characterImage == UIImage(){
                            alertText = "未選取角色"
                            return
                        }
                        uploadPhoto(image: characterImage) { result in
                            switch result {
                            case .success(let url):
                                signUp(imgUrl: url)
                            case .failure(let error):
                               print(error)
                            }
                        }
                    }, label: {
                        HStack {
                            Text("Submit").font(.custom("VCROSDMono", size: 18))
                        }
                        .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 5)
                        )
                        .cornerRadius(10)
                    })
                    
                }
                
            }
        }.onAppear(perform: {
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                print("Family: \(family) Font names: \(names)")
            }
        })
        
    }
    
    func signUp(imgUrl:URL){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user,
                  error == nil else {
                alertText = error!.localizedDescription
                return
            }
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.photoURL = imgUrl
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { error in
               guard error == nil else {
                    alertText = error!.localizedDescription
                   return
               }
            })
            let avatar:String = imgUrl.absoluteString

            let data : GameUser = GameUser(id: user.uid, name: name, avatar: avatar, email: email, age: Int(age), money: 0, gender: roles[selectedIndex], created_at: Date(), updated_at: Date())
            gameUserViewModel.createUser(user: user, gameUser: data)
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
