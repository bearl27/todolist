//
//  NewItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct NewItemsView: View {
    @StateObject var viewModel = NewItemModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack{
            Text("New Item")
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
                        newItemPresented = false
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
    NewItemsView(newItemPresented: Binding(get: {
        return true
    },set: { _ in
        
    }))
}
