//
//  SettingsView.swift
//  PeriodTracker
//
//  Created by Beyza Nur Tekerek on 6.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode  // LoginView'a geri dönmeyi sağlayacak
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("loginBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    if settingsViewModel.isLoading {
                        ProgressView("Yükleniyor...")
                            .padding()
                    } else {
                        if let user = settingsViewModel.user {
                            VStack(spacing: 20) {
                                Text("Ayarlar")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.top, 20)
                                
                                VStack(spacing: 15) {
                                    Text("E-posta: \(user.email)")
                                        .foregroundColor(.white.opacity(0.8))
                                        .font(.system(size: 16, weight: .medium))

                                    CustomTextField(title: "Ad", text: $firstName)
                                    CustomTextField(title: "Soyad", text: $lastName)
                                }
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(15)
                                .padding(.horizontal)

                                Button(action: {
                                    settingsViewModel.updateUser(firstName: firstName, lastName: lastName)
                                }) {
                                    Text("Bilgileri Güncelle")
                                        .bold()
                                        .frame(width: UIScreen.main.bounds.width * 0.8)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                                .padding(.horizontal)

                                Button(action: {
                                    settingsViewModel.logout()  // Çıkış yap
                                    presentationMode.wrappedValue.dismiss()  // LoginView'a yönlendir
                                }) {
                                    Text("Çıkış Yap")
                                        .bold()
                                        .frame(width: UIScreen.main.bounds.width * 0.8)
                                        .padding()
                                        .background(Color.white)
                                        .foregroundColor(.blue)
                                        .cornerRadius(12)
                                }
                                .padding(.horizontal)
                            }
                            .padding()
                            .onAppear {
                                firstName = user.firstName
                                lastName = user.lastName
                            }
                        } else {
                            Text("Kullanıcı verileri yükleniyor...")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .alert(isPresented: $settingsViewModel.showAlert) {
                    Alert(title: Text("Bilgi"), message: Text(settingsViewModel.alertMessage), dismissButton: .default(Text("Tamam")))
                }
            }
        }
    }
}

struct CustomTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 3)
            .padding(.horizontal, 5)
    }
}

#Preview {
    SettingsView(settingsViewModel: SettingsViewModel())
}
