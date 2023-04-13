//
//  ContentView.swift
//  AnimatedRectangles
//
//  Created by Jeff_Terry on 4/13/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var twoDMagnet = TwoDMagnet()
    let upColor = Color(red: 0.25, green: 0.5, blue: 0.75)
    let downColor = Color(red: 0.75, green: 0.5, blue: 0.25)
    let spinWidth = 25.0

    var body: some View {
        VStack(){
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    twoDMagnet.update(to: timeline.date)
                    
                    for spin in twoDMagnet.spins {
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
        }
    }
    
    func setupSpins(){
        
        twoDMagnet.setup(number: Int(spinWidth))
        
    }
}

struct Spin: Hashable, Equatable {
    var x: Double
    var y: Double
    var spin: Bool
}

class TwoDMagnet: ObservableObject {
    //var spins = Set<Spin>()
    var spins :[Spin] = []
    
    func setup(number: Int){
        
        for y in 0..<(number){
            
            for x in 0..<number{
                
                spins.append(Spin(x: Double(x), y: Double(y), spin: true))
                
            }
            
        }
    }

    func update(to date: Date) {
        for i in 0..<spins.count {
            
            spins[i].spin = Bool.random()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
