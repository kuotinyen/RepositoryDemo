//
//  JobRepository.swift
//  RepositoryDemo
//
//  Created by TING YEN KUO on 2019/1/28.
//  Copyright © 2019 TING YEN KUO. All rights reserved.
//

import Foundation
import Alamofire

final class JobRepository {
    private init() {}
    static let shared = JobRepository()
}

// ----------------------------------------------------------------------------------
/// Fetch Job
// MARK: - Fetch Job
// ----------------------------------------------------------------------------------

extension JobRepository {
    
    func fetchJob(by jobId: String, completion: @escaping (Result<Job>) -> ()) {
        
        if let localJob = fetchLocalJob(by: jobId) {
            completion(.success(localJob))
            
            if localJob.timestamp.isExpired() {
                fetchRemoteJob(by: jobId, completion: completion)
            }
            
        } else {
            
            fetchRemoteJob(by: jobId, completion: completion)
        }
       
    }
    
    private func fetchLocalJob(by jobId: String) -> Job? {
        return RealmDB.shared.fetchJob(with: jobId)?.entity
    }
    
    private func fetchRemoteJob(by jobId: String, completion: @escaping (Result<Job>) -> ()) {
        JobsAPI.shared.fetchJob(by: jobId, completion: completion)
    }

}
