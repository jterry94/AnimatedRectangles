//
//  ContentView.swift
//  AnimatedRectangles
//
//  Created by Jeff_Terry on 4/13/23.
//

import SwiftUI
import Observation  

struct ContentView: View {
    @State private var twoDMagnet = TwoDMagnet()
    let upColor = Color(red: 0.25, green: 0.5, blue: 0.75)
    let downColor = Color(red: 0.75, green: 0.5, blue: 0.25)
    let spinWidth = 25.0

    var body: some View {
        VStack(){
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    twoDMagnet.update(to: timeline.date)
                    
                    for spin in twoDMagnet.spinConfiguration.spinConfiguration {
                        let rect = CGRect(x: spin.x * (size.width/CGFloat(spinWidth)), y: spin.y * (size.height/CGFloat(spinWidth)), width: (size.height/CGFloat(spinWidth)), height: (size.height/CGFloat(spinWidth)))
                        let shape = Rectangle().path(in: rect)
                        if (spin.spin){
                            context.fill(shape, with: .color(upColor))}
                        else{
                            context.fill(shape, with: .color(downColor))
                            
                        }
                    }
                }
            }
            
            .background(.black)
            .ignoresSafeArea()
            .padding()
            
            Button("Start", action: setupSpins)
            
            Button("SpinMe", action: changeSpins)
        }
    }
    
    func setupSpins(){
        
        twoDMagnet.setup(number: Int(spinWidth))
        
    }
    
    func spinChangeMethod(thing: inout [Spin]) {
        for i in 0..<twoDMagnet.spinConfiguration.spinConfiguration.count {
            
            thing[i].spin = Bool.random()
        }
    }
    
    func changeSpins(){
        
        Task{
            
            for _ in 0...10000{
                await withTaskGroup(of: Void.self) { group in
                    
                    //Make a copy to avoid working on the struct/
                    var thing = self.twoDMagnet.spinConfiguration.spinConfiguration
                    
                    
                    
                    spinChangeMethod(thing: &thing)
                    
                    self.twoDMagnet.spinConfiguration.spinConfiguration = thing
                    
                    
                }
                
                
            }
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
