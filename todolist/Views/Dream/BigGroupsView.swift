//
//  ItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct BigGroupsView: View {
    @StateObject var viewModel = BigGroupModel()
    let bigGroup: BigGroup
    
    var body: some View {
        HStack{
            Button{
                viewModel.toggleIsDone(bigGroup: bigGroup)
            } label:{
                Image(systemName: bigGroup.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }.padding(.horizontal,20)
            
            VStack(alignment: .leading){
                
                Text(bigGroup.title)
                    .font(.body)
                    .bold()
                Text("\(Date(timeIntervalSince1970: bigGroup.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
            }
            Spacer()
        }
    }
}

#Preview {
    BigGroupsView(bigGroup: .init(id: "123",
                          title: "todo",
                         dueDate: Date().timeIntervalSince1970,
                         createDate: Date().timeIntervalSince1970,
                         isDone: false))
}
