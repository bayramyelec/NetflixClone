//
//  SearchVC.swift
//  NetflixClone
//
//  Created by Bayram Yeleç on 28.12.2024.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    var viewModel = MainViewModel()
    var filteredMovies: [MovieResult] = []
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        reload()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension SearchVC {
    func setup(){
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .black
        setupSearchBar()
        setupTableView()
        setupNaviBar()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func reload(){
        viewModel.fetchTrendingMovies()
        viewModel.reloadTrending = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupSearchBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Search Movies"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .systemGray5
        searchBar.searchTextField.textColor = .white
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupNaviBar(){
        let title = UILabel()
        title.textColor = .white
        title.text = "Trending"
        title.font = .systemFont(ofSize: 20, weight: .bold)
        navigationItem.titleView = title
        navigationController?.navigationBar.standardAppearance.backgroundColor = .black
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMovies.count : viewModel.trendingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        let item = isSearching ? filteredMovies[indexPath.row] : viewModel.trendingList[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.overview
        cell.loadImage(url: item.posterPath ?? "")
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let downloadAction = UIAction(title: "Download", image: UIImage(systemName: "arrow.down.to.line")) { _ in
                print("Download tapped for row \(indexPath.row)")
                
                let item = self.viewModel.trendingList[indexPath.row]
                self.viewModel.addMovieToDownloadList(image: item.posterPath ?? "", title: item.title ?? "")
                
            }
            return UIMenu(title: "", children: [downloadAction])
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredMovies.removeAll()
        } else {
            isSearching = true
            filteredMovies = viewModel.trendingList.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
}
