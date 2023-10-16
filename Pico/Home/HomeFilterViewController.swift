//
//  HomeFilterViewController.swift
//  Pico
//
//  Created by 임대진 on 2023/09/26.
//

import UIKit
import SnapKit

final class HomeFilterViewController: UIViewController {
    
    weak var homeViewController: HomeViewController?
    private let mbtiCollectionViewController = MBTICollectionViewController()
    static var filterChangeState: Bool = false
    private lazy var selectedGenderLabel: UILabel = createFilterLabel(text: "만나고 싶은 성별", font: .picoTitleFont)
    private lazy var selectedGenderSubLabel: UILabel = createFilterLabel(text: "중복 선택 가능", font: .picoDescriptionFont)
    private lazy var selectedAge: UILabel = createFilterLabel(text: "나이", font: .picoSubTitleFont)
    private lazy var selectedDistance: UILabel = createFilterLabel(text: "거리", font: .picoSubTitleFont)
    private lazy var selectedMBTI: UILabel = createFilterLabel(text: "성격 유형", font: .picoSubTitleFont)
    private lazy var manButton: UIButton = createFilterButton(title: "남자")
    private lazy var womanButton: UIButton = createFilterButton(title: "여자")
    private lazy var etcButton: UIButton = createFilterButton(title: "기타")
    
    private let ageSlider = RangeSlider()
    private let distanceSlider = RangeSlider()
    
    // MARK: - 스택
    private lazy var genderHStack: UIStackView = createFilterStack(axis: .horizontal, spacing: 5, distribution: .fillEqually)
    private lazy var genderLabelVStack: UIStackView = createFilterStack(axis: .vertical, spacing: 0, distribution: nil)
    private lazy var genderButtonHStack: UIStackView = createFilterStack(axis: .horizontal, spacing: 5, distribution: .fillEqually)
    private lazy var ageVStack: UIStackView = createFilterStack(axis: .vertical, spacing: 0, distribution: nil)
    private lazy var distanceVStack: UIStackView = createFilterStack(axis: .vertical, spacing: 0, distribution: nil)
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        navigationItem.title = "선호 설정"
        view.configBackgroundColor()
        addSubView()
        makeConstraints()
        
        manButton.isSelected = HomeViewModel.filterGender.contains(.male)
        updateButtonAppearance(manButton)
        
        womanButton.isSelected = HomeViewModel.filterGender.contains(.female)
        updateButtonAppearance(womanButton)
        
        etcButton.isSelected = HomeViewModel.filterGender.contains(.etc)
        updateButtonAppearance(etcButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if HomeFilterViewController.filterChangeState == true {
            self.homeViewController?.reloadView()
            HomeFilterViewController.filterChangeState = false
        }
    }
    
    private func addSubView() {
        view.addSubview(genderHStack)
        view.addSubview(ageVStack)
        view.addSubview(distanceVStack)
        view.addSubview(selectedMBTI)
        
        genderHStack.addArrangedSubview(genderLabelVStack)
        genderHStack.addArrangedSubview(genderButtonHStack)
        genderLabelVStack.addArrangedSubview(selectedGenderLabel)
        genderLabelVStack.addArrangedSubview(selectedGenderSubLabel)
        genderButtonHStack.addArrangedSubview(manButton)
        genderButtonHStack.addArrangedSubview(womanButton)
        genderButtonHStack.addArrangedSubview(etcButton)
        
        ageVStack.addArrangedSubview(selectedAge)
        ageVStack.addArrangedSubview(ageSlider)
        
        distanceVStack.addArrangedSubview(selectedDistance)
        distanceVStack.addArrangedSubview(distanceSlider)
        
        addChild(mbtiCollectionViewController)
        view.addSubview(mbtiCollectionViewController.view)
        mbtiCollectionViewController.didMove(toParent: self)
    }
    
    private func makeConstraints() {
        genderHStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(40)
        }
        
        ageVStack.snp.makeConstraints { make in
            make.top.equalTo(genderHStack.snp.bottom).offset(25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(genderHStack.snp.bottom).offset(100)
        }
        
        distanceVStack.snp.makeConstraints { make in
            make.top.equalTo(ageVStack.snp.bottom).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.bottom.equalTo(ageVStack.snp.bottom).offset(100)
        }
        
        selectedMBTI.snp.makeConstraints { make in
            make.top.equalTo(distanceVStack.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(50)
        }
        
        mbtiCollectionViewController.view.snp.makeConstraints { make in
            make.top.equalTo(selectedMBTI.snp.bottom).offset(5)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.height.equalTo(mbtiCollectionViewController.view.frame.size.height)
        }
    }
    
    private func createFilterLabel(text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        return label
    }
    
    private func createFilterStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution?) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        if let distribution = distribution {
            stack.distribution = distribution
        }
        return stack
    }
    
    private func createFilterButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }
    
    private func updateButtonAppearance(_ button: UIButton) {
        button.backgroundColor = button.isSelected ? .picoBlue : .picoGray
        button.setTitleColor(.white, for: .normal)
    }
    
    @objc func tappedButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        let genderType: GenderType?
        switch sender.currentTitle {
        case "남자":
            genderType = .male
        case "여자":
            genderType = .female
        case "기타":
            genderType = .etc
        default:
            genderType = nil
        }
        if let genderType = genderType {
            if sender.isSelected {
                HomeViewModel.filterGender.append(genderType)
            } else {
                if let index = HomeViewModel.filterGender.firstIndex(of: genderType) {
                    HomeViewModel.filterGender.remove(at: index)
                }
            }
            updateButtonAppearance(sender)
            HomeFilterViewController.filterChangeState = true
        }
    }
}
