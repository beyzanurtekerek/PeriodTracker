//
//  LoginViewModel.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 14.01.2025.
//

import Foundation

// ViewModel, UI ile model arasındaki köprüyü kuracak. LoginViewModel sınıfı ile, kullanıcı etkileşimlerini kontrol edeceğiz.
// Burada, LoginModel‘i ViewModel içinde kullanıyoruz ve onun değişikliklerini view’e yansıtarak UI’nin doğru şekilde güncellenmesini sağlıyoruz.
class LoginViewModel: ObservableObject {
    private var model = LoginModel()

    @Published var email: String = "" {
        didSet {
            model.email = email
        }
    }
    @Published var password: String = "" {
        didSet {
            model.password = password
        }
    }
    @Published var errorMessage: String = ""
    @Published var showToast: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var userFirstName: String = ""
    @Published var userLastName: String = ""
    @Published var isPasswordVisible: Bool = false
    
    init() {
        // Bind model updates to view model
        model.$errorMessage.assign(to: &$errorMessage)
        model.$showToast.assign(to: &$showToast)
        model.$isLoggedIn.assign(to: &$isLoggedIn)
        model.$userFirstName.assign(to: &$userFirstName)
        model.$userLastName.assign(to: &$userLastName)
    }

    // Firebase login fonksiyonunu çağır
    func signInUser() {
        model.signInUser()
        DispatchQueue.main.async {
            // ui guncellemek icin gerekli islemler
        }
    }
}
