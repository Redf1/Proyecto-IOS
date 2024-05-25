//
//  Mispublicaciones.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//

import Foundation

struct Mispublicaciones: Codable, Identifiable{
    let id=UUID()
    var titulo:String
    var imagen:String
    var precio:String
    var descripcion:String
}

class Api : ObservableObject{
    @Published var mispublicaciones=[Mispublicaciones]()
    func loadData(completion:@escaping ([Mispublicaciones])->())
    {
        guard let url=Bundle.main.url(forResource: "mispublicaciones", withExtension: "json")
        else{
            print("url no valida")
            return
        }
        URLSession.shared.dataTask(with: url){
            data, response,error in let mispublicaciones
                = try! JSONDecoder().decode([Mispublicaciones].self, from: data!)
            print(mispublicaciones)
            DispatchQueue.main.async {
                completion(mispublicaciones)
            }
        }.resume()
    }
}
