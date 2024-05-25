import SwiftUI

struct CreatePublicationScreen: View {
    @ObservedObject var viewModel = PublicacionViewModel()
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
        // Contenido principal (NavigationView)
            NavigationView {
                ScrollView {
                    VStack {
                        TextField("Título", text: $viewModel.titulo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        TextField("Precio", value: $viewModel.precio, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        TextField("Descripción", text: $viewModel.descripcion)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        TextField("Imagen", text: $viewModel.imagen)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            self.viewModel.guardarPublicacion()
                        }) {
                            Text("Crear Publicación")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .padding()
                    .offset(x: 0, y: 85)
                    .navigationBarTitle("Crear Publicación") // Título de la barra de navegación
                    .navigationBarItems(leading:
                        HStack {
                            Spacer() // Agregar un Spacer para empujar el botón a la derecha
                            Button(action: {
                                withAnimation {
                                    isMenuVisible.toggle()
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .padding(.horizontal, 20) // Ajustar el padding horizontal del botón
                            }
                        }
                    )
                }
                .background(Color.white) // Para evitar que el color de fondo del menú lateral se vea a través de la barra de navegación
                .edgesIgnoringSafeArea(.vertical)
            }
            .navigationBarHidden(true)
            
            // SideMenuView que se superpone al contenido principal cuando está visible
            if isMenuVisible {
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
                .zIndex(0)
            }
        }
    }
}



struct CreatePublicationScreen_Previews: PreviewProvider {
    static var previews: some View {
        CreatePublicationScreen()
    }
}
