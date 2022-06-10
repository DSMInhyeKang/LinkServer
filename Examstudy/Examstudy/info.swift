//
//  info.swift
//  Examstudy
//
//  Created by 강인혜 on 2022/06/10.
//

import Foundation

struct friendsModel: Codable {
    
    let results: [resultsArr]
    
}

struct resultsArr: Codable {
    
    let name: fullName
    let email: String
    
    struct fullName: Codable {
        let title: String
        let first: String
        let last: String
    }
}
