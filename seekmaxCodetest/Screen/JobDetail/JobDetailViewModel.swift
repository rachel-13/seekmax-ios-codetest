//
//  JobDetailViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation
import Combine

protocol JobDetailViewModel {
  var jobPublisher: Published<JobModel?>.Publisher { get }
  func getData()
  func didTapApply()
}

class JobDetailViewModelImpl: JobDetailViewModel {
  
  var jobPublisher: Published<JobModel?>.Publisher { $job }
  
  let jobID: String
  let service: JobDetailSerivce
  @Published var job: JobModel?
  
  var cancellable = Set<AnyCancellable>()
  
  init(jobId: String, service: JobDetailSerivce) {
    self.service = service
    self.jobID = jobId
    bindToService()
  }
  
  private func bindToService() {
    self.service.jobDetailStream
      .receive(on: DispatchQueue.main)
      .sink { [weak self] result in
        guard let self = self else { return }
        switch result {
        case .success(let jobDetail):
          self.job = JobModel(from: jobDetail)
        case .failure(let err):
          break
        }
      }.store(in: &cancellable)
  }
  
  func getData() {
    self.service.getJobDetail(jobID: self.jobID)
  }
  
  func didTapApply() {
    
  }
}


