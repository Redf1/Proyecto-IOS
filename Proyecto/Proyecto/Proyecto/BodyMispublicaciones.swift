//
//  BodyMispublicaciones.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//

import SwiftUI

struct BodyMispublicaciones: View {
    @State var mispublicaciones = [Mispublicaciones]()
    @State private var isMenuVisible = false // Estado para controlar la visibilidad del menú
    
    var body: some View {
        ZStack {
            // Fondo semi-transparente cuando el menú está abierto
            if isMenuVisible {
                Color.gray.opacity(0.5)
                    .edgesIgnoringSafeArea(.vertical)
                    .onTapGesture {
                        isMenuVisible.toggle() // Cierra el menú al tocar el fondo
                    }
            }
            
            NavigationView {
                VStack {
                    Text("Mis Publicaciones")
                        .font(.body)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    
                    List(mispublicaciones) { mispublicacione in
                        HStack {
                            Image("\(mispublicacione.imagen)")
                                .resizable()
                                .shadow(radius: 50)
                                .frame(width: 100, height: 100)
                            
                            VStack {
                                Text("\(mispublicacione.titulo)")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                
                                Text("\(mispublicacione.precio)")
                                    .font(.body)
                                    .fontWeight(.bold)
                                
                                Text("\(mispublicacione.descripcion)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                            }
                        }
                        Spacer()
                    }
                    .padding(.leading, 6.0)
                    .onAppear() {
                        Api().loadData { (mispublicaciones) in
                            self.mispublicaciones = mispublicaciones
                        }
                    }
                }
                .navigationBarTitle("Tienda Online")
                .navigationBarItems(leading: (
                    Button(action: {
                        withAnimation {
                            self.isMenuVisible.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .padding()
                    }
                ))
            }
            
            
            // Menú lateral
            SideMenuView(onMenuItemSelected: { menuItem in
                print("Menú seleccionado: \(menuItem)")
                isMenuVisible = false // Cierra el menú al seleccionar un elemento
            })
            .frame(width: UIScreen.main.bounds.width / 2)
            .background(Color.white)
            .edgesIgnoringSafeArea(.vertical) // Ajustar para que ocupe toda la altura
            .offset(x: isMenuVisible ? 0 : -UIScreen.main.bounds.width / 2 - 60) // Ajustar el offset
            .animation(.easeInOut(duration: 0.3))
            .transition(.move(edge: .leading))
        }
    }
}

struct BodyMispublicaciones_Previews: PreviewProvider {
    static var previews: some View {
        BodyMispublicaciones()
    }
}
