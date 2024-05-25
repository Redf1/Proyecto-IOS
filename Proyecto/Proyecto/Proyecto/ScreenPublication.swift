//
//  ScreenPublication.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//
import SwiftUI
import FirebaseFirestore


struct ScreenPublication: View {
    @State private var isMenuVisible = false
    @State var publicacionesbody = [PublicacionesBody]()
    
    // Definir el layout de la cuadrícula
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                    Text("Publicaciones")
                        .font(.body)
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(publicacionesbody, id: \.titulo) { publicacion in
                                VStack(alignment: .leading, spacing: 4) {
                                    Image(publicacion.imagen)
                                        .resizable()
                                        .shadow(radius: 50)
                                        .frame(width: 120, height: 100)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(publicacion.titulo)
                                            .font(.body)
                                            .foregroundColor(.blue)
                                            .fontWeight(.bold)
                                        
                                        Text("\(publicacion.precio)")
                                            .font(.body)
                                            .fontWeight(.bold)
                                        
                                        Text(publicacion.descripcion)
                                            .font(.body)
                                            .fontWeight(.semibold)
                                    }
                                    .padding(8)
                                    .background(Color.white.opacity(0.8))
                                }
                            }
                        }
                    }
                    .padding(.leading, 6.0)
                    .offset(x: 0, y: 85)
                    .navigationTitle("Mercado Amigo")
                    .navigationBarItems(leading: (
                        Button(action: {
                            withAnimation {
                                isMenuVisible.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .padding()
                        }
                    ))
                }
                .background(Color.white) // Para evitar que el color de fondo del menú lateral se vea a través de la barra de navegación
                .edgesIgnoringSafeArea(.vertical)
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

    func fetchPublicacionesFromFirebase() {
        let db = Firestore.firestore()
        // Acceder a la colección "publicaciones" y obtener los documentos
        db.collection("publicaciones").getDocuments { snapshot, error in
            if let error = error {
                print("Error obteniendo los documentos: \(error)")
            } else {
                // Borrar las publicaciones existentes antes de cargar nuevas
                self.publicacionesbody.removeAll()
                
                // Iterar sobre los documentos obtenidos
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let email = document["email"] as? String,
                           let precioString = document["precio"] as? String,
                           let precio = Double(precioString),
                           let descripcion = document["descripcion"] as? String,
                           let imagen = document["imagen"] as? String {
                            let publicacion = PublicacionesBody(titulo: email, precio: precio, descripcion: descripcion, imagen: imagen)
                            self.publicacionesbody.append(publicacion)
                        }
                    }
                }
            }
        }
    }
}

struct ScreenPublication_Previews: PreviewProvider {
    static var previews: some View {
        ScreenPublication()
    }
}

