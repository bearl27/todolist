//
//  NewItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct NewMidGroupsView: View {
    @StateObject var viewModel = NewMidGroupModel()
    @Binding var newMidGroupPresented: Bool
    
    var body: some View {
        VStack{
            Text("New MidGroup")
                .font(.system(size: 32))
                .bold()
                .padding(.top,30)
            
            Form{
                //Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                //Due Data
                DatePicker("Due Data", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                //Button
                TLButton(title: "Save",
                         background: .blue
                ){
                    if viewModel.canSave{
                        viewModel.save()
                        newMidGroupPresented = false
                    } else{
                        viewModel.showAlert = true
                    }
                }
                         .padding()
            }
            .alert(isPresented: $viewModel.showAlert, content: {
                Alert(title: Text("Error"), message: Text("正しい日時で登録してください"))
            })
        }
    }
}

#Preview {
    NewMidGroupsView(newMidGroupPresented: Binding(get: {
        return true
    },set: { _ in
        
    }))
}
