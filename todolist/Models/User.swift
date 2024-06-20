//
//  User.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import Foundation

struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    var doneItemNum: Int
    var doneMidNum: Int
    var doneDreamNum: Int
    
    mutating func plusDoneItemNum(_ state: Bool){
        if state{
            doneItemNum = doneItemNum + 1
        }else{
            doneItemNum = doneItemNum - 1
        }
    }
}

