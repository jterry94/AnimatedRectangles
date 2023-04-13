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
    let downColor = Color(red: 0.275, green: 0.5, blue: 0.25)
    let spinWidth = 25.0

    var body: some View {
        VStack(){
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    twoDMagnet.update(to: timeline.date)
                    
                    for spin in twoDMagnet.spins {
                        let rect = CGRect(x: spin.x * (size.width/CGFloat(spinWidth)), y: spin.y * (size.height/CGFloat(spinWidth)), width: (size.height/CGFloat(spinWidth)), height: (size.height/CGFloat(spinWidth)))
                        let shape = Capsule().path(in: rect)
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
            
           // let x = spins[i].x
            //let y = spins[i].y
            
            spins[i].spin = Bool.random()
        }
    }
}



//
//struct ContentView: View {
//    @StateObject private var storm = Storm()
//    let rainColor = Color(red: 0.25, green: 0.5, blue: 0.75)
//
//    var body: some View {
//        TimelineView(.animation) { timeline in
//            Canvas { context, size in
//                storm.update(to: timeline.date)
//
//                for drop in storm.drops {
//                    let age = timeline.date.distance(to: drop.removalDate)
//                    let rect = CGRect(x: drop.x * size.width, y: size.height - (size.height * age * drop.speed), width: 2, height: 10)
//                    let shape = Capsule().path(in: rect)
//                    context.fill(shape, with: .color(rainColor))
//                }
//            }
//        }
//        .background(.black)
//        .ignoresSafeArea()
//    }
//}
//
//struct Raindrop: Hashable, Equatable {
//    var x: Double
//    var removalDate: Date
//    var speed: Double
//}
//
//class Storm: ObservableObject {
//    var drops = Set<Raindrop>()
//
//    func update(to date: Date) {
//        drops = drops.filter { $0.removalDate > date }
//        drops.insert(Raindrop(x: Double.random(in: 0...1), removalDate: date + 1, speed: Double.random(in: 1...2)))
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
