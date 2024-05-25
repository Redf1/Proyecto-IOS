//
//  ForgotPasswordScreen.swift
//  Proyecto
//
//  Created by Ruben on 5/20/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ForgotPasswordScreen: View {
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var securityAnswer: String = ""
    @State private var verificationCode: String = ""
    @State private var newPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var resetPasswordSuccess = false
    
    var body: some View {
        VStack {
            TextField("Correo electrónico", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Número de teléfono", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Respuesta de seguridad", text: $securityAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Código de verificación", text: $verificationCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Nueva contraseña", text: $newPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        resetPasswordSuccess = true
                    }
                }
            }) {
                Text("Restablecer Contraseña")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .alert(isPresented: $resetPasswordSuccess) {
            Alert(title: Text("Correo enviado"), message: Text("Se ha enviado un correo electrónico para restablecer tu contraseña."), dismissButton: .default(Text("OK")))
        }
    }
}


struct ForgotPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordScreen()
    }
}
