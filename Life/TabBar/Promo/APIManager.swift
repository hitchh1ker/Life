//
//  APIManager.swift
//  Life
//
//  Created by Максим Шамов on 25.01.2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func getPromo(completion: @escaping ([Promo]) -> Void){
        let url = URL(string: "https://sklad-zdorovo.ru/api/promo")!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data else { return }
            if let promoData = try? JSONDecoder().decode(PromoData.self, from: data) {
                completion(promoData.promos)
            } else {
                print("Fail")
            }
        }
        task.resume()
    }
    
    func getGoodsPromo(promoId: Int, limit: Int, offset: Int, completion: @escaping ([Good]) -> Void) {
        let urlString = "https://sklad-zdorovo.ru/api/promo/\(promoId)/goods?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response or status code")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let goodsData = try JSONDecoder().decode(GoodsData.self, from: data)
                completion(goodsData.goods)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
