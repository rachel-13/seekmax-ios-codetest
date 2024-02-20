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
typealias JobDetailResponse = GetJobDetailQuery.Data.Job

protocol JobListService {
  var jobsStream: PassthroughSubject<Result<JobListResponse, JobServiceError>, Never> { get }
  func getJobs(limit: Int, page: Int)
}

protocol JobDetailSerivce {
  var jobDetailStream: PassthroughSubject<Result<JobDetailResponse, JobServiceError>, Never> { get }
  func getJobDetail(jobID: String)
}

class JobServiceImpl: JobListService {
  
  var jobsStream: PassthroughSubject<Result<JobListResponse, JobServiceError>, Never> = PassthroughSubject()
  var jobDetailStream: PassthroughSubject<Result<JobDetailResponse, JobServiceError>, Never> = PassthroughSubject()
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
  
  private func handleErrors(errors: [GraphQLError]?) {
    guard let errors = errors, let firstErr = errors.first?.message else { return }
    self.jobsStream.send(.failure(JobServiceError.unknown))
  }
}

extension JobServiceImpl: JobDetailSerivce {
  
  func getJobDetail(jobID: String) {
    let query = GetJobDetailQuery(jobId: jobID)
    self.client.apollo.fetch(query: query) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let response):
        guard response.errors == nil else {
          self.handleErrors(errors: response.errors)
          return
        }
        
        guard let jobDetail = response.data?.job else {
          return
        }
        
        self.jobDetailStream.send(.success(jobDetail))
      case .failure(let err):
        break
      }
    }
  }
}
