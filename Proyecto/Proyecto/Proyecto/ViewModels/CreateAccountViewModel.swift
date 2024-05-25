//
//  CreateAccountViewModel.swift
//  Proyecto
//
//  Created by Ruben on 5/20/24.
//


import Foundation
import Firebase

class CreateAccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    
    func createUser() {
        // Crea un nuevo usuario con los datos proporcionados
        let newUser = User(email: email, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        // Guarda el usuario en Firebase
        saveUserToFirebase(newUser)
    }
    
    private func saveUserToFirebase(_ user: User) {
        // Accede a la instancia compartida de Firestore
        let db = Firestore.firestore()
        // Agrega un nuevo documento en la colección 'users' con el ID igual al correo electrónico del usuario
        db.collection("users").document(user.email).setData([
            "firstName": user.firstName,
            "lastName": user.lastName,
            "phoneNumber": user.phoneNumber
        ]) { error in
            if let error = error {
                print("Error guardando usuario en Firestore: \(error)")
            } else {
                print("Usuario guardado exitosamente en Firestore")
            }
        }
    }
}
