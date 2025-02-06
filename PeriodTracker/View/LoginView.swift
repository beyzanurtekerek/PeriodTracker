import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    // yönlendirmenin view'da kullanılmasının nedeni görünüs odakli olanların viewda kullanılması gerektigindendir.
    @State private var navigateToSignUp: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                    Text("Hoş Geldiniz 🌸")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()

                    // E-MAİL GİRİS
                    TextField("E-mail", text: $viewModel.email)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width * 0.8,height: UIScreen.main.bounds.height * 0.055)
                        .background(Color.white)
                        .cornerRadius(13)
                        .padding(.horizontal, UIScreen.main.bounds.width * 0.1)

                    // SİFRE GİRİS
                    HStack {
                        if viewModel.isPasswordVisible {
                            TextField("Şifre", text: $viewModel.password)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                                .background(Color.white)
                                .cornerRadius(13)
                                .overlay(
                                    Button(action: {
                                        viewModel.isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    },
                                    alignment: .trailing
                                )
                        } else {
                            SecureField("Şifre", text: $viewModel.password)
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                                .background(Color.white)
                                .cornerRadius(13)
                                .overlay(
                                    Button(action: {
                                        viewModel.isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: viewModel.isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 10)
                                    },
                                    alignment: .trailing
                                )
                        }
                    }

                    // HATA MESAJI
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    // GİRİS YAP BUTONU
                    Button(action: {
                        viewModel.signInUser()
                    }) {
                        Text("Giriş Yap")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.055)
                            .background(.blue.opacity(0.76))
                            .cornerRadius(13)
                    }

                    // UYE OL BAGLANTISI
                    Button(action: {
                        navigateToSignUp.toggle()
                    }) {
                        Text("Hesabınız yok mu? Üye olun")
                            .font(.subheadline)
                            .foregroundColor(.blue.opacity(0.8))
                    }
                    .padding(.top, 10)
                    .sheet(isPresented: $navigateToSignUp) {
                        SignUpView()
                    }

                    Spacer()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.1)

                // TOAST MESAJI
                if viewModel.showToast {
                    VStack {
                        Spacer()
                        Text("Başarıyla Giriş Yapıldı!")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding()
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.5), value: viewModel.showToast)
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                MainTabView(firstName: viewModel.userFirstName)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
