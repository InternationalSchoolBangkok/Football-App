//
//  Player.swift
//  Soccer
//
//  Created by Pearl on 4/16/2560 BE.
//  Copyright © 2560 Pearl. All rights reserved.
//

import UIKit

class Player: NSObject {

    var number:Int = 0
    var name:String = ""
    var passYNum:Int = 0
    var passYLocation:[CGPoint]?
    var passNNum:Int = 0
    var passNLocation:[CGPoint]?
    
    static let sharedInstance = [Player]()
 
    init(name:String, number:Int) {
        self.name = name
        self.number = number
    }
}

