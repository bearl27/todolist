//
//  LoginView.swift
//  todolist
//
//  Created by kai on 2024/03/23.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginModel()
    
  
    var body: some View {
        NavigationView{
            VStack{
                //header
                HeaderView(title: "ログイン", subtitle: "ようこそ", angle: 15, background: .blue)
                    .offset(y: -100)
                
                
                
                //Login Form
                Form{
                    
                    TextField("メールアドレス",
                              text:$viewModel.email).textFieldStyle(DefaultTextFieldStyle())
                    
                    SecureField("パスワード",
                                text:$viewModel.password).textFieldStyle(DefaultTextFieldStyle())
                    
                    if !viewModel.errormessage.isEmpty{
                        Text(viewModel.errormessage)
                            .foregroundColor(.red)
                    }
                    
                    TLButton(title: "ログイン",
                             background: .blue)
                    {
                        //action
                        viewModel.login()
                    }
                    .padding()
                }
                
                //Create Account
                HStack{
                    Text("アカウントを持っていない方は")
                    NavigationLink("こちら",destination: RegView())
                }.padding(.bottom,50)
                
        
            }
        }
    }
}

#Preview {
    LoginView()
}
