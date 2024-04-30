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
    let profileImageURL: String
}
