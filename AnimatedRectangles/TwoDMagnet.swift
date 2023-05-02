//
//  TwoDMagnet.swift
//  AnimatedRectangles
//
//  Created by Jeff_Terry on 4/30/23.
//

import SwiftUI

class TwoDMagnet: ObservableObject {
    
    @ObservedObject var spinConfiguration = Spins()
    
    func setup(number: Int){
        
        for y in 0..<(number){
            
            for x in 0..<number{
                
                spinConfiguration.spinConfiguration.append(Spin(x: Double(x), y: Double(y), spin: true))
                
            }
            
        }
    }

    func update(to date: Date) {
        
    }
}
