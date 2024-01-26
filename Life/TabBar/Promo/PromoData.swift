//
//  PromoData.swift
//  Life
//
//  Created by Максим Шамов on 25.01.2024.
//

import Foundation

struct PromoData: Codable {
    let totalCount: Int
    let promos: [Promo]
}

struct Promo: Codable {
    let id: Int
    let title, dateStart, dateEnd, image: String
}
