//
//  JobDetailModel.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import Foundation

struct JobModel {
  
  var companyName: String {
    return job._id ?? "Confidential Company"
  }
  
  var positionTitle: String {
    return job.positionTitle ?? "Confidential position title"
  }
  
  var salary: String {
    guard let salaryRange = job.salaryRange else {
      return "No salary range"
    }
    
    guard let min = salaryRange.min else {
      return ""
    }
    
    guard let max = salaryRange.max else {
      return ""
    }
    
    return String(format: "%@ %d - %@ %d", currency, min, currency, max)
  }
  
  var location: String {
    return "Confidential location"
  }
  
  var industry: String {
    return "Confidential industry"
  }
  
  var positionDesc: String {
    if let description = job.description {
      return description
    }
    return "Confidential description"
  }
  
  var buttonDisabled: Bool {
    return job.haveIApplied ?? false
  }
  
  var buttonTitle: String {
    return buttonDisabled ? "Applied" : "Apply Now"
  }
  
  let job: JobDetailResponse
  let currency: String
  
  init(from job: JobDetailResponse, localCurrency: String = "MYR") {
    self.job = job
    self.currency = localCurrency
  }
}
