//
//  JobService.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import Combine
import SeekmaxAPI
import Apollo

typealias JobListResponse = GetActiveJobsListQuery.Data.Active

protocol JobService {
  var jobsStream: PassthroughSubject<Result<JobListResponse, GetListError>, Never> { get }
  func getJobs(limit: Int, page: Int)
  func applyForJob(jobID: String)
}

class JobServiceImpl: JobService {
  
  var jobsStream: PassthroughSubject<Result<JobListResponse, GetListError>, Never> = PassthroughSubject()
  let client: NetworkClient
  
  init(client: NetworkClient) {
    self.client = client
  }
  
  func getJobs(limit: Int, page: Int) {
    let query = GetActiveJobsListQuery(limit: GraphQLNullable(integerLiteral: limit), page: GraphQLNullable(integerLiteral: page))
    self.client.apollo.fetch(query: query) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let response):
        guard response.errors == nil else {
          self.handleErrors(errors: response.errors)
          return
        }
        
        guard let active = response.data?.active else {
          return
        }
        
        self.jobsStream.send(.success(active))
      case .failure(let err):
        break
      }
    }
    
  }
  
  func applyForJob(jobID: String) {
    
  }
  
  private func handleErrors(errors: [GraphQLError]?) {
    guard let errors = errors, let firstErr = errors.first?.message else { return }
    self.jobsStream.send(.failure(GetListError.unknown))
  }
}
