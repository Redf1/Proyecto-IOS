//
//  CreateAccountView.swift
//  Proyecto
//
//  Created by Ruben on 5/20/24.
//

import SwiftUI

struct CreateAccountView: View {
    @ObservedObject var viewModel = CreateAccountViewModel()
   var body: some View {
       VStack {
           TextField("Correo electrónico", text: $viewModel.email)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
           
           TextField("Nombre", text: $viewModel.firstName)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
           
           TextField("Apellido", text: $viewModel.lastName)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
           
           TextField("Teléfono", text: $viewModel.phoneNumber)
               .textFieldStyle(RoundedBorderTextFieldStyle())
               .padding()
           
           Button(action: {
               viewModel.createUser()
           }) {
               Text("Crear Usuario")
                   .foregroundColor(.white)
                   .padding()
                   .background(Color.blue)
                   .cornerRadius(8)
           }
           .padding()
           Spacer()
       }
       .padding()
   }

}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
