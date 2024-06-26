//
//  ItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct ItemsView: View {
    @StateObject var viewModel = ItemModel()
    let item: Item
    @Environment(\.locale) var locale: Locale
    
    var body: some View {
        HStack{
            Button{
                viewModel.toggleIsDone(item: item)
            } label:{
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }.padding(.horizontal,20)
            
            VStack(alignment: .leading){
                
                if item.isDone {
                    Text(item.title)
                        .font(.body)
                        .bold()
                        .strikethrough()
                }else{
                    Text(item.title)
                        .font(.body)
                        .bold()
                }
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
    }
}

#Preview {
    ItemsView(item: .init(id: "123",
                          title: "todo",
                         dueDate: Date().timeIntervalSince1970,
                         createDate: Date().timeIntervalSince1970,
                          parent:MidGroup( id: "001",
                                           title: "mid",
                                           dueDate: Date().timeIntervalSince1970,
                                           createDate: Date().timeIntervalSince1970,
                                           parent: BigGroup(id: "002",
                                                            title: "big",
                                                            dueDate: Date().timeIntervalSince1970,
                                                            createDate: Date().timeIntervalSince1970,
                                                            isDone: false),
                                           isDone: false),
                         isDone: false))
}
