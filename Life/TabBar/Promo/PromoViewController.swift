//
//  PromoViewController.swift
//  Life
//
//  Created by Максим Шамов on 24.01.2024.
//

import UIKit

class PromoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        APIManager.shared.getPromo{ [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.promoData = values
                self.tableView.reloadData()
            }
        }
    }
    
    private var promoData: [Promo] = []
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        promoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellTable = tableView.dequeueReusableCell(withIdentifier: "cellPromo", for: indexPath) as? PromoTableViewCell else {
            return UITableViewCell()
        }
        cellTable.promoName.text = promoData[indexPath.row].title
        if let imageURL = URL(string: "https://sklad-zdorovo.ru" + promoData[indexPath.row].image) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        cellTable.promoImage.image = image
                    }
                }
            }
        }
        return cellTable
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPromo = promoData[indexPath.row]

        // Используйте идентификатор вашего контроллера из Storyboard
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "GoodsViewController") as? GoodsViewController {
            detailViewController.promo = selectedPromo
            navigationController?.pushViewController(detailViewController, animated: false)
        } else {
            print("Failed to instantiate GoodsViewController from the storyboard.")
        }
    }
}
