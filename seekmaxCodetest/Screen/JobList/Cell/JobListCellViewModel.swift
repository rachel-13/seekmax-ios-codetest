//
//  JobListCellViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation
import SeekmaxAPI

protocol JobListCellViewModel {
  var positionTitle: String { get }
  var positionDesc: String { get }
  var applied: String { get }
}

class JobListCellViewModelImpl: JobListCellViewModel {
  var positionTitle: String {
    return job._id ?? ""
  }
  
  var positionDesc: String {
    return job.positionTitle ?? ""
  }
  
  var applied: String {
    return job.haveIApplied ?? false ? "Applied" : "Apply Now"
  }
  
  
  let job: JobListResponse.Job
  
  init(job: JobListResponse.Job) {
    self.job = job
  }
}
