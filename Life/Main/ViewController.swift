//
//  ViewController.swift
//  Life
//
//  Created by Максим Шамов on 24.01.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
        self.navigationController?.pushViewController(vc, animated: false)
    }


}

