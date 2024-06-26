//
//  ToDoListView.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MidView: View {
    @StateObject var viewModel: MidModel
    @FirestoreQuery var midGroups: [MidGroup]
    
    
    init(userId: String) {
        self._midGroups = FirestoreQuery(
            collectionPath: "users/\(userId)/midGoal"
        )
        
        self._viewModel = StateObject(
            wrappedValue: MidModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List(midGroups) { midGroup in
                    MidGroupsView(midGroup: midGroup)
                        .swipeActions{
                            Button("Delete"){
                                //Delete
                                viewModel.delete(id: midGroup.id)
                            }
                            .tint(.red)
                        }
                }
            }
            .navigationTitle("中間目標")
            .toolbar{
                Button{
                    //action
                    viewModel.showingNewMidGroupView = true
                } label: {
                    Image(systemName: "plus")
                }
                
                Button{
                    //action
                    for midGroup in midGroups {
                        if midGroup.isDone {
                            viewModel.delete(id: midGroup.id)
                        }
                    }
                        
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .sheet(isPresented: $viewModel.showingNewMidGroupView, content: {
                NewMidGroupsView(newMidGroupPresented: $viewModel.showingNewMidGroupView)
            })
        }
    }
}

#Preview {
    MidView(userId: "S1We86qx9qhO62SVNIpYbsyH9NG3")
}
