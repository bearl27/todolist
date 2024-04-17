//
//  ToDoListView.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct DreamView: View {
    @StateObject var viewModel: DreamModel
    @FirestoreQuery var bigGroups: [BigGroup]
    
    init(userId: String) {
        self._bigGroups = FirestoreQuery(
            collectionPath: "users/\(userId)/bigGoal"
        )
        
        self._viewModel = StateObject(
            wrappedValue: DreamModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List(bigGroups) { bigGroup in
                    BigGroupsView(bigGroup: bigGroup)
                        .swipeActions{
                            Button("Delete"){
                                //Delete
                                viewModel.delete(id: bigGroup.id)
                            }
                            .tint(.red)
                        }
                }
            }
            .navigationTitle("Dream")
            .toolbar{
                Button{
                    //action
                    viewModel.showingNewBigGroupView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewBigGroupView, content: {
                NewBigGroupsView(newBigGroupPresented: $viewModel.showingNewBigGroupView)
            })
        }
    }
}

#Preview {
    DreamView(userId: "S1We86qx9qhO62SVNIpYbsyH9NG3")
}
