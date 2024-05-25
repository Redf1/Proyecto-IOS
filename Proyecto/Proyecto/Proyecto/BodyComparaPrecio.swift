//
//  BodyComparaPrecio.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//

import SwiftUI

struct BodyComparaPrecio: View {
    @State var comparaPrecios = [ComparaPrecios]()
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
                    Text("Comparar Precios")
                        .font(.body)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    
                    List(comparaPrecios) { comparaPrecio in
                        HStack{
                            Image("\(comparaPrecio.imagen)")
                                .resizable()
                                .shadow(radius: 50)
                                .frame(width: 100, height: 100)
                            VStack{
                                Text("\(comparaPrecio.titulo)")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                Text("\(comparaPrecio.precio)")
                                    .font(.body)
                                    .fontWeight(.bold)
                                Text("\(comparaPrecio.descripcion)")
                                    .font(.body)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(.leading, 6.0)
                    .onAppear() {
                        Api2().loadData { (comparaPrecios) in
                            self.comparaPrecios = comparaPrecios
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
            .background(Color.blue)
            .edgesIgnoringSafeArea(.vertical) // Ajustar para que ocupe toda la altura
            .offset(x: isMenuVisible ? 0 : -UIScreen.main.bounds.width / 2 - 60) // Ajustar el offset
            .animation(.easeInOut(duration: 0.3))
            .transition(.move(edge: .leading))
        }
    }
}

struct BodyComparaPrecio_Previews: PreviewProvider {
    static var previews: some View {
        BodyComparaPrecio()
    }
}
