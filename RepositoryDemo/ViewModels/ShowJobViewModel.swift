//
//  ShowJobViewModel.swift
//  RepositoryDemo
//
//  Created by TING YEN KUO on 2019/1/28.
//  Copyright © 2019 TING YEN KUO. All rights reserved.
//

import Foundation

class ShowJobViewModel {
    
    var job: Job?
    var jobId: String!
    var reloadDataClosure: (() -> Void)?
    
    init(jobId: String) {
        self.jobId = jobId
    }
    
    func loadData() {

        JobRepository.shared.fetchJob(by: jobId) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let job):
                self.job = job
                self.reloadDataClosure?()
            case .failure(let error):
                print("error -> \(error)")
            }
        }
    }
    
}
