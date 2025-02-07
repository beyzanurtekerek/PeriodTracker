//
//  SettingsViewModel.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 7.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class SettingsViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    private let db = Firestore.firestore()
    
    init() {
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        isLoading = true
        db.collection("users").document(userID).getDocument { snapshot, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.showAlert(message: "Veri alınırken hata oluştu: \(error.localizedDescription)")
                    return
                }
                if let data = snapshot?.data() {
                    self.user = User(
                        id: userID,
                        firstName: data["firstName"] as? String ?? "",
                        lastName: data["lastName"] as? String ?? "",
                        email: data["email"] as? String ?? ""
                    )
                }
            }
        }
    }
    
    func updateUser(firstName: String, lastName: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        isLoading = true
        db.collection("users").document(userID).updateData([
            "firstName": firstName,
            "lastName": lastName
        ]) { error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.showAlert(message: "Güncelleme başarısız: \(error.localizedDescription)")
                    return
                }
                self.user?.firstName = firstName
                self.user?.lastName = lastName
                self.showAlert(message: "Bilgiler başarıyla güncellendi! ✅")
            }
        }
    }
    
    
    // Çıkış yapma fonksiyonu
    func logout() {
        do {
            try Auth.auth().signOut() // Firebase'den çıkış yap
            isLoggedIn = false // Giriş durumunu güncelle
            UserDefaults.standard.set(false, forKey: "isLoggedIn") // Giriş durumu kaydedildi
        } catch {
            print("Çıkış işlemi başarısız: \(error.localizedDescription)")
        }
    }
    
    private func showAlert(message: String) {
        self.alertMessage = message
        self.showAlert = true
    }
}
