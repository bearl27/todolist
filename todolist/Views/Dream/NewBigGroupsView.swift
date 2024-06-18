//
//  NewItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct NewBigGroupsView: View {
    @StateObject var viewModel = NewBigGroupModel()
    @Binding var newBigGroupPresented: Bool
    @Environment(\.locale) var locale: Locale
    
    var body: some View {
        VStack{
            Text("新しい夢")
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
                    .environment(\.locale, Locale(identifier: "ja_JP"))
                
                //Button
                TLButton(title: "Save",
                         background: .blue
                ){
                    if viewModel.canSave{
                        viewModel.save()
                        newBigGroupPresented = false
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
    NewBigGroupsView(newBigGroupPresented: Binding(get: {
        return true
    },set: { _ in
        
    }))
}
