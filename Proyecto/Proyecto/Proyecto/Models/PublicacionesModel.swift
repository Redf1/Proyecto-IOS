//
//  PublicacionesModel.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//

import Foundation

struct Publicaciones: Codable, Identifiable{
    let id=UUID()
    var titulo:String
    var imagen:String
    var precio:String
    var descripcion:String
}

class Api_ : ObservableObject{
    @Published var publicaciones=[Publicaciones]()
    func loadData(completion:@escaping ([Publicaciones])->())
    {
        guard let url=Bundle.main.url(forResource: "publicaciones", withExtension: "json")
        else{
            print("url no valida")
            return
        }
        URLSession.shared.dataTask(with: url){
            data, response,error in let publicaciones
                = try! JSONDecoder().decode([Publicaciones].self, from: data!)
            print(publicaciones)
            DispatchQueue.main.async {
                completion(publicaciones)
            }
        }.resume()
    }
}
