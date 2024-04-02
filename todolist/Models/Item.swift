//
//  Item.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import Foundation

struct Item: Codable, Identifiable{
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool){
        isDone = state
    }
}
