//
//  ProfileView.swift
//  todolist
//
//  Created by kai on 2024/04/01.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileModel()
    @State private var selectedImage: UIImage? // 選択された写真を保持する変数
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $viewModel.showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
        .onAppear {
            viewModel.fetchUser()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        Group {
            // Avatar
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 125, height: 125)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.blue)
                    .frame(width: 125, height: 125)
            }
        }
        .onTapGesture {
            viewModel.showImagePicker = true
        }

        Form {
            // Info
            Section(header: Text("User Information")) {
                HStack {
                    Text("Name:")
                    Spacer()
                    Text(user.name)
                }

                HStack {
                    Text("Email:")
                    Spacer()
                    Text(user.email)
                }

                HStack {
                    Text("Member Since:")
                    Spacer()
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                }
            }

            // Sign out
            Section {
                Button("Log Out") {
                    viewModel.logOut()
                }
                .tint(.red)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}
