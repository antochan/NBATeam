//
//  HomeView.swift
//  NBATeams
//
//  Created by Antonio Chan on 2020/2/29.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    public var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isEditing = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(tableView)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
