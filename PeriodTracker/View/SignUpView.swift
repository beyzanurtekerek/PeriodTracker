//
//  SignUpView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 6.01.2025.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var errorMessage: String = ""
    @State private var isToastVisible: Bool = false // Toast görünürlüğü
    @State private var toastMessage: String = ""    // Toast mesajı

    var body: some View {
        ZStack {
            // ARKA PLAN
            Image("loginBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                Text("PERIOD TRACKER")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pink.opacity(0.6))
                    .padding(.top, UIScreen.main.bounds.height * 0.05)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                Text("Yeni Hesap Oluştur 🌸")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                
                // İSİM GİRİS
                TextField("Ad", text: $firstName)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                    .background(Color.white)
                    .cornerRadius(13)
                
                // SOYAD GİRİS
                TextField("Soyad", text: $lastName)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                    .background(Color.white)
                    .cornerRadius(13)
                
                // E-MAİL GİRİŞ
                TextField("E-mail", text: $email)
                    .padding()
                    .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                    .background(Color.white)
                    .cornerRadius(13)
                
                // ŞİFRE GİRİŞ
                passwordField(title: "Şifre", text: $password, isVisible: $isPasswordVisible)
                
                // ŞİFRE TEKRAR GİRİŞ
                passwordField(title: "Şifre Tekrar", text: $confirmPassword, isVisible: $isConfirmPasswordVisible)
                
                // HATA MESAJI
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // ÜYE OL BUTONU
                Button(action: {
                    signUpUser(email: email, password: password, confirmPassword: confirmPassword, firstName: firstName, lastName: lastName)
                }) {
                    Text("Üye Ol")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                        .background(.blue.opacity(0.76))
                        .cornerRadius(13)
                }
                
                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.1)
            .ignoresSafeArea()
            
            // TOAST MESAJI
            if isToastVisible {
                VStack {
                    Spacer()
                    Text(toastMessage)
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                }
                .transition(.slide)
                .animation(.easeInOut, value: isToastVisible)
            }
        }
    }
    
    func passwordField(title: String, text: Binding<String>, isVisible: Binding<Bool>) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13)
                .fill(Color.white)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
            
            HStack {
                if isVisible.wrappedValue {
                    TextField(title, text: text)
                        .padding(.leading, 10) // Sol boşluk
                } else {
                    SecureField(title, text: text)
                        .padding(.leading, 10) // Sol boşluk
                }
                Spacer()
                Button(action: {
                    isVisible.wrappedValue.toggle()
                }) {
                    Image(systemName: isVisible.wrappedValue ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10) // Sağ boşluk
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
        }
    }
    
    func signUpUser(email: String, password: String, confirmPassword: String, firstName: String, lastName: String) {
        if password != confirmPassword {
            self.errorMessage = "Şifreler uyuşmuyor!"
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = ""
                let user = result?.user
                
                let db = Firestore.firestore()
                db.collection("users").document(user!.uid).setData([
                    "firstName": firstName,
                    "lastName": lastName,
                    "email": email
                ]) { error in
                    if let error = error {
                        self.errorMessage = "Kullanıcı bilgileri kaydedilemedi: \(error.localizedDescription)"
                    } else {
                        print("Kullanıcı kaydedildi.")
                        showToast(message: "Üyelik başarıyla oluşturuldu!")
                    }
                }
            }
        }
    }

    func showToast(message: String) {
        toastMessage = message
        withAnimation {
            isToastVisible = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isToastVisible = false
            }
        }
    }
}

#Preview {
    SignUpView()
}
