//
//  JobListVC.swift
//  RepositoryDemo
//
//  Created by TING YEN KUO on 2019/1/27.
//  Copyright © 2019 TING YEN KUO. All rights reserved.
//

import UIKit

class JobListVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 30,right: 0)
        
        let tv = UITableView()
            .backgroundColor(Theme.grayColor)
            .contentInset(contentInset)
            .separatorStyle(.none)
            .estimatedRowHeight(44)
            .dataSource(self)
            .delegate(self)
        
        tv.registerReusableCell(JobListCell.self)
        
        return tv
    }()
    
    var displayViewModels = ["1", "2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}

// ----------------------------------------------------------------------------------
/// TableView Delegate funcs
// MARK: - TableView Delegate funcs
// ----------------------------------------------------------------------------------

extension JobListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(forIndexPath: indexPath) as JobListCell
        return cell
    }
    
}


