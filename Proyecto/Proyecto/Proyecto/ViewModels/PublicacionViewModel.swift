import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class PublicacionViewModel: ObservableObject {
    @Published var titulo: String = ""
    @Published var precio: Double = 0
    @Published var descripcion: String = ""
    @Published var imagen: String = ""

    func guardarPublicacion() {
        let db = Firestore.firestore()
        
        guard let usuario = Auth.auth().currentUser else {
            print("No se ha iniciado sesión.")
            return
        }

        let email = usuario.email ?? "Correo electrónico del Creador"

        let publicacionData: [String: Any] = [
            "titulo": self.titulo,
            "precio": self.precio,
            "descripcion": self.descripcion,
            "imagen": self.imagen,
            "email": email
        ]
        
        db.collection("publicaciones").addDocument(data: publicacionData) { error in
            if let error = error {
                print("Error al guardar la publicación: \(error.localizedDescription)")
            } else {
                print("Publicación guardada exitosamente")
            }
        }
    }

    private func getNextPublicacionId(completion: @escaping (Int?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("publicaciones")
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error al obtener las publicaciones: \(error.localizedDescription)")
                    completion(nil)
                } else {
                    let nextId = snapshot?.documents.count ?? 0 + 1
                    completion(nextId)
                }
            }
    }
}
