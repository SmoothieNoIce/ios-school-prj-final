//
//  GamePage.swift
//  ios-school-prj-final
//
//  Created by User17 on 2021/5/5.
//

import SwiftUI
import SpriteKit
import GameplayKit
import FirebaseAuth
import FirebaseFirestoreSwift
import Firebase

class GameScene: SKScene {
    var touchBall:Bool = false
    var ball:SKShapeNode!
    var circle:SKShapeNode!
    var cameraNode = SKShapeNode()
    var player: SKSpriteNode!
    override func didMove(to view: SKView) {
        create_JoyStick()
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    func create_JoyStick(){
        ball = SKShapeNode(circleOfRadius: 15)
        ball.name = "ball"
        ball.zPosition = 2
        ball.position = CGPoint(x: 60, y: 60)
        ball.fillColor = .white
        ball.strokeColor = .white
        addChild(ball)
        
        circle = SKShapeNode(circleOfRadius: 30)
        circle.fillColor = .clear
        circle.strokeColor = .white
        circle.lineWidth = 5
        circle.position = ball.position
        addChild(circle)
        
    }
    
    func create_Player(){
        player = SKSpriteNode(texture: SKTexture(imageNamed: ""))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: SKColor.red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        //addChild(box)
        
        if atPoint(location).name == "ball"{
            touchBall = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let convertLocation = self.convert(location, to: cameraNode)
        if touchBall{let dx = convertLocation.x - circle.position.x
            let dy = convertLocation.y - circle.position.y
            let angle = atan2(dy, dx)
            ball.position = convertLocation
            let square = sqrt(dx*dx + dy*dy)
            if square >= 100{
                ball.position = CGPoint(x: cos(angle)*100 + circle.position.x, y:sin(angle)*100 + circle.position.y)
            }else{
                ball.position = convertLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ball.position = circle.position
        touchBall = false
    }
}

struct GamePage: View {
    @Binding var currentPage : Page
    var scene: SKScene {
         let scene = GameScene()
         scene.size = CGSize(width: 300, height: 400)
         scene.scaleMode = .aspectFit
         return scene
     }
    var body: some View {
        SpriteView(scene: scene)
                .ignoresSafeArea()
    }
}

struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        GamePage(currentPage: .constant(Page.GAME_PAGE))
    }
}
