//
//  HomeViewController.swift
//  NBATeams
//
//  Created by Antonio Chan on 2020/2/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    private var webService: WebService?
    
    init(webService: WebService) {
        self.webService = webService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    private var viewModel: HomeViewModel = HomeViewModel(teams: TeamData(data: [])) {
        didSet {
            DispatchQueue.main.async {
                self.homeView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        requestAllTeams()
    }
    
    func setupTableView() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TeamCell")
    }
    
    func requestAllTeams() {
        guard let webService = webService else { return }
        webService.fetchData(urlString: "https://www.balldontlie.io/api/v1/teams", objectType: TeamData.self) { [weak self] (result: WebService.Result) in
            guard let strongSelf = self else { return }
            switch result {
            case .failure(let error):
                // Handle errors here like alert view
                print(error)
            case .success(let object):
                strongSelf.viewModel = HomeViewModel(teams: object)
            }
        }
    }

}

extension HomeViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = viewModel.listOfAllTeams[sourceIndexPath.row]
        var copyOfList = viewModel.listOfAllTeams
        copyOfList.remove(at: sourceIndexPath.row)
        copyOfList.insert(movedObject, at: destinationIndexPath.row)
        viewModel = HomeViewModel(teams: TeamData(data: copyOfList))
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfAllTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewModel.listOfAllTeams[indexPath.row].full_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        return false
    }
}
