//
//  JobListViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import Foundation
import Combine
import SeekmaxAPI

protocol JobListViewModel {
  func didTapJob(index: Int)
  func fetchJobs()
}

class JobListViewModelImpl: JobListViewModel {
  var cancellable = Set<AnyCancellable>()
  let service: JobService
  var size = 10
  var page = 1
  var total = 0
  var hasNext = false
  
  init(service: JobService) {
    self.service = service
    bindToService()
  }
  
  private func bindToService() {
    self.service.jobsStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        guard let self = self else { return }
        
        switch result {
        case .success(let jobList):
          self.hasNext = jobList.hasNext ?? false
          self.page += 1
        case .failure(let err):
          break
        }
        
      }.store(in: &cancellable)
  }
  
  func fetchJobs() {
    self.service.getJobs(limit: size, page: page)
  }
  
  func didTapJob(index: Int) {
    
  }
}
