//
//  LoginModel.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import Foundation
import FirebaseAuth
import Firebase

// Bu modelde, login işlemi ve kullanıcı verilerini almakla ilgili işlevleri merkezileştirdik.
class LoginModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var showToast: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userFirstName: String = ""
    @Published var userLastName: String = ""
    @Published var isPasswordVisible: Bool = false

    // Firebase ile giriş fonksiyonu
    func signInUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = ""
                self.fetchUserData()
                
                // Toast ve isLoggedIn işlemleri
                DispatchQueue.main.async {
                    self.showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.showToast = false
                        self.isLoggedIn = true
                    }
                }
            }
        }
    }
    // Firestore kullanıcı verilerini al
    func fetchUserData() {
        let user = Auth.auth().currentUser
        if let userId = user?.uid {
            let db = Firestore.firestore()
            db.collection("users").document(userId).getDocument { document, error in
                if let document = document, document.exists {
                    self.userFirstName = document.get("firstName") as? String ?? ""
                    self.userLastName = document.get("lastName") as? String ?? ""
                }
            }
        }
    }
}
