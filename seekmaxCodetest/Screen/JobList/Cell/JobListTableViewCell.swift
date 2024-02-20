//
//  JobListTableViewCell.swift
//  seekmaxCodetest
//
//  Created by pohz on 19/02/2024.
//

import UIKit

class JobListTableViewCell: UITableViewCell {
  
  lazy var containerView: UIView = {
    let view = UIView().withAutoLayout()
    return view
  }()
  
  lazy var positionTitle: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textColor = Theme.Color.textPrimary
    lbl.font = Theme.Font.title2
    return lbl
  }()
  
  lazy var positionDesc: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textColor = Theme.Color.textPrimary
    lbl.font = Theme.Font.body
    return lbl
  }()
  
  lazy var appliedLabel: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textColor = Theme.Color.textPrimary
    lbl.font = Theme.Font.caption
    return lbl
  }()
  
  func configure(with viewModel: JobListCellViewModel) {
    setupUI()
    self.positionTitle.text = viewModel.positionTitle
    self.positionDesc.text = viewModel.positionDesc
    self.appliedLabel.text = viewModel.applied
  }
  
  func setupUI() {
    self.selectionStyle = .none
    self.containerView.layer.cornerRadius = 10
    self.containerView.layer.shadowOpacity = 1
    self.containerView.layer.shadowColor = Theme.Color.darkGrayShadow.cgColor
    self.containerView.layer.shadowRadius = 4
    self.containerView.layer.shadowOffset = CGSize(width: 5, height: 5)
    self.contentView.backgroundColor = Theme.Color.lightGrayBackground
    self.containerView.backgroundColor = Theme.Color.white
    
    self.contentView.addSubview(containerView)
    self.containerView.addSubview(positionTitle)
    self.containerView.addSubview(positionDesc)
    self.containerView.addSubview(appliedLabel)
    
    NSLayoutConstraint.activate([
      
      self.containerView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: Theme.Dimension.CellMargin),
      self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Theme.Dimension.CellMargin),
      self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Theme.Dimension.CellMargin),
      
      self.positionTitle.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: Theme.Dimension.Margin),
      self.positionTitle.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
      self.positionTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Theme.Dimension.Margin),
      self.positionTitle.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      self.positionDesc.topAnchor.constraint(equalTo: self.positionTitle.bottomAnchor, constant: Theme.Dimension.Margin/2),
      self.positionDesc.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
      self.positionDesc.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Theme.Dimension.Margin),
      self.positionDesc.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Theme.Dimension.Margin),
      
      self.appliedLabel.topAnchor.constraint(equalTo: self.positionDesc.bottomAnchor, constant: Theme.Dimension.Margin),
      self.appliedLabel.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor),
      self.appliedLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: Theme.Dimension.Margin),
      self.appliedLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -Theme.Dimension.Margin),
      self.appliedLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -Theme.Dimension.Margin)
    ])
  }
  
  
}
