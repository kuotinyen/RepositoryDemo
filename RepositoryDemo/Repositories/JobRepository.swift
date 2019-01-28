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
            fetchRemoteJobIfNeeded(job: localJob, completion: completion)
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
    
    private func fetchRemoteJobIfNeeded(job: Job, completion: @escaping (Result<Job>) -> ()) {
        
        let savedTimestamp = job.timestamp
        let savedDate = Date(timeIntervalSince1970: TimeInterval(savedTimestamp))
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        print("last fetch date: \(dformatter.string(from: savedDate))")
        
        let timeIntervalSinceNow = savedDate.timeIntervalSinceNow
        let secondsLimit = 60 // minute
        let shouldUpdateJobFromRemote = Int(-timeIntervalSinceNow) > secondsLimit
        
        if shouldUpdateJobFromRemote {
            fetchRemoteJob(by: job.jobId, completion: completion)
        }
    }

}
