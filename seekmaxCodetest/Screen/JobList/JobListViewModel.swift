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
  var cellViewModels: [JobListCellViewModel] { get }
  var cellViewModelPublisher: Published<[JobListCellViewModel]>.Publisher { get }
  var hasNext: Bool { get }
  var total: Int { get }
  func didTapJob(index: Int)
  func fetchJobs()
}

class JobListViewModelImpl: JobListViewModel {
  var cellViewModelPublisher: Published<[JobListCellViewModel]>.Publisher { $cellViewModels }
  var cancellable = Set<AnyCancellable>()
  let service: JobService
  var size = 10
  var page = 1
  var total = 0
  var hasNext = false
  var coordinatorDelegate: JobListCoordinator?
  
  @Published var cellViewModels: [JobListCellViewModel] = []
  
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
          guard let activeJobs = jobList.jobs else {
            return
          }
          
          self.hasNext = jobList.hasNext ?? false
          self.total = jobList.total ?? 0
          self.page += 1
          let parsedJobs = activeJobs.map { job in
            guard let unwrappedJob = job else {
              fatalError("No job found")
            }
            return JobListCellViewModelImpl(job: unwrappedJob)
          }
          self.cellViewModels.append(contentsOf: parsedJobs)
        case .failure(let err):
          break
        }
        
      }.store(in: &cancellable)
  }
  
  func fetchJobs() {
    self.service.getJobs(limit: size, page: page)
  }
  
  func didTapJob(index: Int) {
    coordinatorDelegate?.showDetailsFor(jobId: cellViewModels[index].companyName)
  }
}
