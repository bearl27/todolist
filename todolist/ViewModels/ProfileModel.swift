import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileModel: ObservableObject {
    init() {}
    
    @Published var user: User? = nil
    @Published var showImagePicker = false
    
    private let storage = Storage.storage().reference()
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0,
                    profileImageURL: data["profileImageURL"] as? String ?? ""
                )
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("error")
        }
    }
    
    func uploadImage(_ image: UIImage) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let imageRef = storage.child("profile_images/\(userId).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Upload error: \(error.localizedDescription)")
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("Download URL error: \(error.localizedDescription)")
                    return
                }
                
                guard let downloadURL = url?.absoluteString else {
                    return
                }
                
                self.saveProfileImageURL(downloadURL)
            }
        }
    }
    
    private func saveProfileImageURL(_ url: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData([
            "profileImageURL": url
        ], merge: true)
    }
}

struct User: Identifiable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
    let profileImageURL: String
}
