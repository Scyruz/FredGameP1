//
//  Top10.swift
//  FredGame
//
//  Created by user188455 on 3/15/21.
//

import Foundation

class Top10 {
    var top10List : [Int64] = []
    
    func add(newScore : Int64) {
        top10List.append(newScore)
        top10List = top10List.sorted().reversed()
        
        if top10List.count > 10 {
            top10List = Array(top10List[0...9])
        }
    }
}
