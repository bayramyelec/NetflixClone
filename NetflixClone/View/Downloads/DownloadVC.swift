//
//  DownloadVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit

class DownloadVC: UIViewController {
    
    private let tableView = UITableView()
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadDownloaded = { [weak self] in
            print("İndirilen filmler yenileniyor")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension DownloadVC {
    func setup(){
        setupUI()
        setupTableView()
    }
    func setupUI(){
        view.backgroundColor = .black
    }
    func setupTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DownloadTableViewCell.self, forCellReuseIdentifier: DownloadTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension DownloadVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.downloadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.identifier, for: indexPath) as! DownloadTableViewCell
        let item = viewModel.downloadList[indexPath.row]
        cell.titleLabel.text = item.title
        cell.loadImage(url: item.image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 3
    }
    
}
