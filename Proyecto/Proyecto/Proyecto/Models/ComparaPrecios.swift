//
//  ComparaPrecios.swift
//  Proyecto
//
//  Created by Ruben on 5/21/24.
//

import Foundation

struct ComparaPrecios: Codable, Identifiable{
    let id=UUID()
    var titulo:String
    var imagen:String
    var precio:String
    var descripcion:String
    
}

class Api2 : ObservableObject{
    @Published var comparaPrecio=[ComparaPrecios]()
    func loadData(completion:@escaping ([ComparaPrecios])->())
    {
        guard let url=Bundle.main.url(forResource: "ComparaPrecio", withExtension: "json")
        else{
            print("url no valida")
            return
        }
        URLSession.shared.dataTask(with: url){
            data, response,error in let comparaPrecio
                = try! JSONDecoder().decode([ComparaPrecios].self, from: data!)
            print(comparaPrecio)
            DispatchQueue.main.async {
                completion(comparaPrecio)
            }
        }.resume()
    }
}
