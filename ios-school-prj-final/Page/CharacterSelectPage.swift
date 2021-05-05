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
    
    let hats = ["* None", "BAG", "CAT", "BANANA", "DOUBLE", "SIGN","BALLOON1","BAT","WOLF","WILDWEST","PAPER","HALO"]
    let outfits = ["* None", "WHITESUIT", "JACKET", "BALLERINA", "HEARTS"]
    let bodys = ["BASE", "BLACK", "RED", "GREEN", "ORANGE","YELLOW","WHITE","PURPLE","PINK","BLUE"]
    let pets = ["* None", "MINI9", "DOG", "PEGASUS", "BRAINSLUG", "STICKWOMAN","ROBOT","HAMSTER","MINI5"]

    @State var currentHat = 0
    @State var currentOutfit = 0
    @State var currentBody = 0
    @State var currentPet = 0
    @Binding var characterImage : UIImage
    
    @Binding var currentPage : Page
    
    var charaterView: some View {
        ZStack{
            Image(bodys[currentBody]).resizable()
                .scaledToFit().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 0, y: 0)
            Image(hats[currentHat]).resizable()
                .scaledToFit().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 0, y: 0)
            Image(outfits[currentOutfit]).resizable()
                .scaledToFit().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 0, y: 0)
            Image(pets[currentPet]).resizable()
                .scaledToFit().frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: -20, y: 0)
        }.frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    var body: some View {
        ZStack{
            Image("backgroundimg")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    VStack( spacing: nil, content: {
                        Text("角色製造機").font(.system(size: 40)).colorInvert()
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
                        Text("帽子").colorInvert()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(hats.indices , id:\.self) { index in
                                    Button(action: {
                                        currentHat = index
                                    }){
                                        Image(hats[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("衣服").colorInvert()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(outfits.indices , id:\.self) { index in
                                    Button(action: {
                                        currentOutfit = index
                                    }){
                                        Image(outfits[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                    HStack{
                        Text("身體").colorInvert()
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
                    HStack{
                        Text("寵物").colorInvert()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(pets.indices , id:\.self) { index in
                                    Button(action: {
                                        currentPet = index
                                    }){
                                        Image(pets[index]).resizable()
                                            .scaledToFit().frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    }
                                }
                            }
                        }
                    }
                    Button(action: {
                        currentHat = Int.random(in: 0..<hats.count)
                        currentOutfit = Int.random(in: 0..<outfits.count)
                        currentBody = Int.random(in: 0..<bodys.count)
                        currentPet = Int.random(in: 0..<pets.count)
                    }) {
                        HStack {
                            Text("隨機")
                        }
                        .padding(.trailing,30).padding(.leading,30).padding(.top,10).padding(.bottom,10)
                        .foregroundColor(.white)
                        .background(Color(.systemGreen))
                        .cornerRadius(10)
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
