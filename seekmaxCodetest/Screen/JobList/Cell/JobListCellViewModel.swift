//
//  JobListCellViewModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation
import SeekmaxAPI

protocol JobListCellViewModel {
  var companyName: String { get }
  var positionTitle: String { get }
  var positionDesc: String { get }
  var applied: String { get }
}

class JobListCellViewModelImpl: JobListCellViewModel {
  var companyName: String {
    return job._id ?? ""
  }
  
  var positionTitle: String {
    return job.positionTitle ?? ""
  }
  
  var positionDesc: String {
    return job.description ?? ""
  }
  
  var applied: String {
    return job.haveIApplied ?? false ? "Applied" : "Apply Now"
  }
  
  let job: JobListResponse.Job
  
  init(job: JobListResponse.Job) {
    self.job = job
  }
}
