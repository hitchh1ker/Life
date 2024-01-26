//
//  GoodsViewController.swift
//  Life
//
//  Created by Максим Шамов on 25.01.2024.
//

import UIKit

class GoodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    var promo: Promo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        if let promoId = promo?.id {
            APIManager.shared.getGoodsPromo(promoId: promoId, limit: 10, offset: 0) { [weak self] values in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.goodsData = values
                    self.tableView.reloadData()
                }
            }
        } else {
            // Обработка ситуации, когда promo или его id отсутствуют
            print("No promo or promo id available.")
        }
    }
    
    private var goodsData: [Good] = []
    
    func setupTableView() {
        func setupTableView() {
            if let tableView = tableView {
                tableView.delegate = self
                tableView.dataSource = self
            } else {
                print("tableView is nil")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goodsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellTable = tableView.dequeueReusableCell(withIdentifier: "cellGoods", for: indexPath) as? GoodsTableViewCell else {
            return UITableViewCell()
        }
        
        if let imageURL = URL(string: "https://sklad-zdorovo.ru" + goodsData[indexPath.row].images[0]) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cellTable.goodsImage.image = image
                    }
                }
            }
        }
        cellTable.goodsName.text = goodsData[indexPath.row].name
        cellTable.goodsProducer.text = goodsData[indexPath.row].producer
        if let availability = goodsData[indexPath.row].availability {
            cellTable.goodsAvailability.text = "В наличии: \(availability) аптек от \(goodsData[indexPath.row].startPrice) руб"
        } else {
            cellTable.goodsAvailability.text = "Недоступно"
        }
        if goodsData[indexPath.row].inStock == false {
            cellTable.goodsInStock.text = "В аптеке"
        }
        cellTable.goodsBuyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cellTable.goodsBuyBtn.setTitle("От \(goodsData[indexPath.row].startPrice) \u{20BD}", for: .normal)
        
        return cellTable
    }
}
