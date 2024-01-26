//
//  GoodsTableViewCell.swift
//  Life
//
//  Created by Максим Шамов on 25.01.2024.
//

import UIKit

class GoodsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var goodsProducer: UILabel!
    @IBOutlet weak var goodsAvailability: UILabel!
    @IBOutlet weak var goodsInStock: UILabel!
    @IBOutlet weak var goodsImage: UIImageView!
    @IBOutlet weak var goodsBuyBtn: UIButton!
}
