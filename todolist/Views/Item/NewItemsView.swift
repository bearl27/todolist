//
//  NewItemsView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI
import FirebaseFirestoreSwift

struct NewItemsView: View {
    @StateObject var viewModel = NewItemModel()
    @Binding var newItemPresented: Bool
    
    //PickerView
    @State private var selectedOption = 0
    let options = ["Option 1", "Option 2", "Option 3"]
    //@FirestoreQuery var midGroups: [MidGroup]
    
    @Environment(\.locale) var locale: Locale
    
    
    var body: some View {
        VStack{
            Text("新しいタスク")
                .font(.system(size: 32))
                .bold()
                .padding(.top,30)
            
            Form{
                //Title
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                //Parent
                Picker("Parent", selection: $selectedOption) {
                                ForEach(0..<options.count) { index in
                                    Text(options[index])
                                }
                            }
                
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
