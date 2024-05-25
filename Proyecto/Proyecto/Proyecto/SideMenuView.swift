//
//  SideMenuView.swift
//  Proyecto
//
//  Created by Ruben on 5/23/24.
//

import SwiftUI

struct SideMenuView: View {
    var onMenuItemSelected: (MenuOption) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(destination: BodyComparaPrecio()) {
                Text("Compara Precio")
                    .padding()
            }
            
            NavigationLink(destination: BodyMispublicaciones()) {
                Text("Mis Publicaciones")
                    .padding()
            }
            
            NavigationLink(destination: ScreenPublication()) {
                Text("Publicaciones")
                    .padding()
            }
            
            NavigationLink(destination: CreatePublicationScreen()) {
                Text("Crear Publicación")
                    .padding()
            }
        }
        .frame(width: UIScreen.main.bounds.width / 2)
        .background(Color.white)
    }
}

enum MenuOption {
    case comparaPrecio
    case misPublicaciones
    case publicaciones
    case crearPublicacion
}
