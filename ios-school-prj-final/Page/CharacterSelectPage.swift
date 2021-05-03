//
//  CharacterSelectPage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/3.
//

import SwiftUI

struct PlayCharacter{
    var head : String
    var emote : String
    var body : String
}

struct CharacterSelectPage: View {
    
    let heads = ["Afro", "Medium Bangs", "Medium Straight", "Twists 2", "Twists"]
    let emotes = ["Smile", "Smile Teeth Gap", "Smile Big", "Calm", "Angry with Fang"]
    let bodys = ["crossed_arms-2", "easing-2", "polka_dots", "resting-1", "shirt-4"]

    
    @Binding var currentPage : Page
    var body: some View {
        ZStack{
            Color(.systemPink).ignoresSafeArea()
            VStack{
                HStack{
                    VStack{
                        Text("角色製造機").font(.system(size: 24)).colorInvert()
                        Spacer()
                    }
                    ZStack{
                        Image(heads[0]).resizable()
                            .scaledToFit().frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 35, y: -330)
                        Image(emotes[2]).resizable()
                            .scaledToFit().frame(width: 58, height: 58, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 45, y: -315)
                        Image(bodys[1]).resizable()
                            .scaledToFit().frame(width: 250, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).offset(x: 50, y: -100)
                    }
                   
                }.padding(.top,50)
                VStack{
                    HStack{
                        Text("頭部")
                        
                    }
                    HStack{
                        Text("臉部")
                    }
                    HStack{
                        Text("身體")
                    }
                }.offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct CharacterSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        CharacterSelectPage(currentPage: .constant(Page.LOGIN_PAGE))
    }
}
