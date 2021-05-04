//
//  CharacterSelectPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}


struct CharacterSelectPage: View {
    
    let heads = ["Afro", "Medium Bangs", "Medium Straight", "Twists 2", "Twists"]
    let emotes = ["Smile", "Smile Teeth Gap", "Smile Big", "Calm", "Angry with Fang"]
    let bodys = ["crossed_arms-2", "easing-2", "polka_dots", "resting-1", "shirt-4"]
    
    @State var currentHead = 0
    @State var currentEmote = 0
    @State var currentBody = 0
    @Binding var characterImage : UIImage
    
    @Binding var currentPage : Page
    
    var charaterView: some View {
        ZStack{
            Image(heads[currentHead]).resizable()
                .scaledToFit().frame(width: 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 17, y: -175)
            Image(emotes[currentEmote]).resizable()
                .scaledToFit().frame(width: 55, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 24, y: -160)
            Image(bodys[currentBody]).resizable()
                .scaledToFit().frame(width: 250, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 25, y: 50)
        }
    }
    
    var body: some View {
        ZStack{
            Color(.systemPink).ignoresSafeArea()
            VStack{
                HStack{
                    VStack( spacing: nil, content: {
                        Text("角色製造機").font(.system(size: 24)).colorInvert()
                        Button(action: {
                            currentPage = Page.SIGN_UP_PAGE
                            characterImage = charaterView.snapshot()
                        }) {
                            HStack {
                                Text("確定")
                            }
                            .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                            .foregroundColor(.white)
                            .background(Color(.systemGreen))
                            .cornerRadius(10)
                        }
                    })
                    charaterView
                }.padding(.top,50)
                VStack{
                    HStack{
                        Text("頭部")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(heads.indices , id:\.self) { index in
                                    Button(action: {
                                        currentHead = index
                                    }){
                                        Image(heads[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("臉部")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(emotes.indices , id:\.self) { index in
                                    Button(action: {
                                        currentEmote = index
                                    }){
                                        Image(emotes[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("身體")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(bodys.indices , id:\.self) { index in
                                    Button(action: {
                                        currentBody = index
                                    }){
                                        Image(bodys[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                }.offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct CharacterSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectPage(characterImage: .constant(UIImage()), currentPage: .constant(Page.LOGIN_PAGE))
    }
}
