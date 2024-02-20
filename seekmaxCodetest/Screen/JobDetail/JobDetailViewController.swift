//
//  JobDetailViewController.swift
//  seekmaxCodetest
//
//  Created by pohz on 20/02/2024.
//

import UIKit
import Combine

class JobDetailViewController: UIViewController {
  
  lazy var scrollView: UIScrollView = {
    let sv = UIScrollView().withAutoLayout()
    return sv
  }()
  
  lazy var stackView: UIStackView = {
    let stack = UIStackView().withAutoLayout()
    stack.axis = .vertical
    stack.distribution = .fill
    return stack
  }()
  
  lazy var companyName: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    lbl.font = Theme.Font.title
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  lazy var positionTitle: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.textAlignment = .center
    lbl.font = Theme.Font.title
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  lazy var positionDescHeader: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.title3
    lbl.textColor = Theme.Color.textPrimary
    lbl.text = "Description"
    return lbl
  }()
  
  lazy var positionDesc: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.body2
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  
  lazy var salaryHeader: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.title3
    lbl.textColor = Theme.Color.textPrimary
    lbl.text = "Salary Range"
    return lbl
  }()
  
  lazy var salary: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.caption
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  lazy var industryHeader: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.title3
    lbl.textColor = Theme.Color.textPrimary
    lbl.text = "Industry"
    return lbl
  }()
  
  lazy var industry: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.caption
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  
  lazy var locationHeader: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.title3
    lbl.textColor = Theme.Color.textPrimary
    lbl.text = "Location"
    return lbl
  }()
  
  lazy var location: UILabel = {
    let lbl = UILabel().withAutoLayout()
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    lbl.font = Theme.Font.caption
    lbl.textColor = Theme.Color.textPrimary
    return lbl
  }()
  
  lazy var applyButton: UIButton = {
    let btn = UIButton().withAutoLayout()
    btn.setTitleColor(Theme.Color.white, for: .normal)
    btn.setTitleColor(Theme.Color.textPrimary, for: .highlighted)
    btn.titleLabel?.font = Theme.Font.button
    btn.backgroundColor = Theme.Color.backgroundBrand
    btn.layer.cornerRadius = 10.0
    btn.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
    return btn
  }()
  
  let viewModel: JobDetailViewModel
  var cancellable = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindToViewModel()
    viewModel.getData()
  }
  
  init(viewModel: JobDetailViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func bindToViewModel() {
    self.viewModel.jobPublisher
      .receive(on: DispatchQueue.main)
      .sink { [weak self] job in
        guard let self = self, let job = job else { return }
        self.companyName.text = job.companyName
        self.positionTitle.text = job.positionTitle
        self.salary.text = (job.salary)
        self.location.text = job.location
        self.industry.text = job.industry
        self.positionDesc.text = job.positionDesc
        
        self.applyButton.setTitle(job.buttonTitle, for: .normal)
        self.applyButton.isEnabled = !job.buttonDisabled
        self.applyButton.backgroundColor = self.applyButton.isEnabled ? Theme.Color.backgroundBrand : Theme.Color.backgroundSecondary
      }.store(in: &cancellable)
  }
  
  private func setupUI() {
    self.view.backgroundColor = Theme.Color.white
    self.view.addSubview(scrollView)
    
    self.scrollView.addSubview(stackView)
    self.stackView.addArrangedSubview(companyName)
    self.stackView.addArrangedSubview(positionTitle)
    self.stackView.addArrangedSubview(salaryHeader)
    self.stackView.addArrangedSubview(salary)
    self.stackView.addArrangedSubview(industryHeader)
    self.stackView.addArrangedSubview(industry)
    self.stackView.addArrangedSubview(locationHeader)
    self.stackView.addArrangedSubview(location)
    self.stackView.addArrangedSubview(positionDescHeader)
    self.stackView.addArrangedSubview(positionDesc)
    self.stackView.addArrangedSubview(UIView()) /// filler
    self.stackView.addArrangedSubview(applyButton)
    self.stackView.spacing = Theme.Dimension.Margin
    
    
    NSLayoutConstraint.activate([
      self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      
      self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: Theme.Dimension.Margin * 3),
      self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Theme.Dimension.Margin),
      self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Theme.Dimension.Margin),
      self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
      
      self.applyButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Theme.Dimension.Margin * 2),
      self.applyButton.heightAnchor.constraint(equalToConstant: Theme.Dimension.ButtonHeight)
    ])
  }
  
  @IBAction private func didTapApply() {
    // TODO: handle applying jobs
  }
}
