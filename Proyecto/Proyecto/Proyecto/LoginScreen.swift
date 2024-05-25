//
//  LoginScreen.swift
//  Proyecto
//
//  Created by Ruben on 5/20/24.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct LoginScreen: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var error: String?
    var body: some View {
        NavigationView {
            VStack {
                Image("Profile")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
                TextField("Correo electrónico", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Contraseña", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(destination: ScreenPublication(), isActive: $isLoggedIn) { EmptyView() // Esto permite que el botón sea invisible pero aún activo
                }
                Button(action: {
                    signIn()
                }) {
                    Text("Iniciar sesión")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
    
                NavigationLink(destination: CreateAccountView()) {
                    Text("Crear Cuenta")
                        .foregroundColor(.blue)
                }
                .padding()
                if let error = error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                NavigationLink(destination: ForgotPasswordScreen()) {
                    Text("¿Olvidaste tu contraseña?")
                        .foregroundColor(.blue)
                }
                .padding()
                Spacer()
            }
            .padding()
            .navigationBarTitle("Login", displayMode: .inline)
        }
    }
    private func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Manejar el error
                self.error = error.localizedDescription
            } else {
                // Inicio de sesión exitoso
                self.isLoggedIn = true
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
