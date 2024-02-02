//
//  APIManager.swift
//  Life
//
//  Created by Максим Шамов on 25.01.2024.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    func getPromoAsync(completion: @escaping ([Promo]) -> Void) {
        let url = URL(string: "https://sklad-zdorovo.ru/api/promo")!
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            if let promoData = try? JSONDecoder().decode(PromoData.self, from: data) {
                DispatchQueue.main.async {
                    completion(promoData.promos)
                }
            } else {
                print("Fail")
            }
        }
        task.resume()
    }
    
    func getGoodsPromoAsync(promoId: Int, limit: Int, offset: Int, completion: @escaping ([Good]) -> Void) {
        let urlString = "https://sklad-zdorovo.ru/api/promo/\(promoId)/goods?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            if let goodsData = try? JSONDecoder().decode(GoodsData.self, from: data) {
                DispatchQueue.main.async {
                    completion(goodsData.goods)
                }
            } else {
                print("Fail")
            }
        }
        task.resume()
    }
}
