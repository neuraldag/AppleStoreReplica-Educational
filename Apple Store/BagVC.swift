//
//  BagVC.swift
//  Apple Store
//
//  Created by Gamid Gapizov on 24.01.2024.
//

import UIKit

final class BagVC: UIViewController {

    private let theLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(theLabel)
        theLabel.text = "Yum."
        theLabel.textColor = .white
        theLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.tabBarController?.tabBar.backgroundColor = .black
    }

}
