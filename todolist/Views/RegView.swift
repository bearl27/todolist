//
//  RegView.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import SwiftUI

struct RegView: View {
    
    @StateObject var viewModel = RegModel()
    
    var body: some View {
        VStack{
            //Header
            HeaderView(title: "新規登録", subtitle: "ともに夢を叶えよう！！", angle: 0, background: .orange)
                .offset(y: -100)
        }
        //Reg Form
        Form{
            TextField("名前",
                      text: $viewModel.name).textFieldStyle(DefaultTextFieldStyle())
            TextField("メールアドレス",
                      text: $viewModel.email).textFieldStyle(DefaultTextFieldStyle())
            SecureField("パスワード",
                        text: $viewModel.password).textFieldStyle(DefaultTextFieldStyle())
            
            if !viewModel.errormesage.isEmpty{
                Text(viewModel.errormesage)
                    .foregroundColor(.red)
            }
            
            if !viewModel.emailError.isEmpty{
                Text(viewModel.emailError)
                    .foregroundColor(.red)
            }
            
            if !viewModel.passError.isEmpty{
                Text(viewModel.passError)
                    .foregroundColor(.red)
            }
            
            TLButton(title: "アカウントを作る",
                     background: .green)
            {
                //action
                viewModel.register()
            }
            .padding()
            
        }
        
        Spacer()
    }
}

#Preview {
    RegView()
}
