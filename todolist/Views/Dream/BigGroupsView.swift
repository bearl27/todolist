//
//  ItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct BigGroupsView: View {
    @StateObject var viewModel = BigGroupModel()
    @StateObject var childViewModel = MidGroupModel()
    @StateObject var main = MainModel()
    
    let bigGroup: BigGroup
    
    var body: some View {
        HStack {
            Button {
                viewModel.toggleIsDone(bigGroup: bigGroup)
            } label: {
                Image(systemName: bigGroup.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 20)
            
            VStack(alignment: .leading) {
                if bigGroup.isDone {
                    Text(bigGroup.title)
                        .font(.body)
                        .bold()
                        .strikethrough()
                }else{
                    Text(bigGroup.title)
                        .font(.body)
                        .bold()
                }
                Text("\(Date(timeIntervalSince1970: bigGroup.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            NavigationLink {
                MidView(userId: main.currentUserId)
            } label: {
                
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    BigGroupsView(bigGroup: .init(id: "123",
                          title: "BigGroup",
                         dueDate: Date().timeIntervalSince1970,
                         createDate: Date().timeIntervalSince1970,
                         isDone: false))
}
