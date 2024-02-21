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
  var isDataChangedPublisher: Published<Bool>.Publisher { get }
  var hasNext: Bool { get }
  var total: Int { get }
  func didTapJob(index: Int)
  func fetchJobs()
}

class JobListViewModelImpl: JobListViewModel {
  var isDataChangedPublisher: Published<Bool>.Publisher { $isDataChanged }
  var cancellable = Set<AnyCancellable>()
  let service: JobListService
  var size = 10
  var page = 1
  var total = 0
  var hasNext = false
  var coordinatorDelegate: JobListCoordinator?
  
  var cellViewModels: [JobListCellViewModel] = []
  @Published var isDataChanged = false
  
  init(service: JobListService) {
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
          self.isDataChanged = true
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
