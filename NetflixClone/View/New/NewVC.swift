//
//  NewVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit

class NewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}
extension NewVC {
    func setup(){
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .black
    }
}
