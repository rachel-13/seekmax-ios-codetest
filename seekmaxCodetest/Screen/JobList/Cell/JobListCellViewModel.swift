//
//  JobListCellViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation
import SeekmaxAPI

protocol JobListCellViewModel {
  var job: JobModel { get }
}

class JobListCellViewModelImpl: JobListCellViewModel {
  let job: JobModel
  
  init(job: JobModel) {
    self.job = job
  }
}
