//
//  TopUserDetailViewController.swift
//  Pico
//
//  Created by 신희권 on 2023/09/25.
//

import UIKit

final class BasicInformationViewContoller: UIViewController {
    private var mbtiLabelView: MBTILabelView = MBTILabelView(mbti: .enfj, scale: .large)
    private let nameAgeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.picoTitleFont
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "map")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    private let heightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "ruler")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "168cm"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        makeConstraints()
        
    }
    
    func config(mbti: MBTIType, nameAgeText: String, locationText: String, heightText: String?) {
        mbtiLabelView.setMbti(mbti: mbti)
        nameAgeLabel.text = nameAgeText
        locationLabel.text = locationText
        
        if let heightText = heightText {
            heightLabel.text = " \(heightText) cm"
        } else {
            [heightImageView, heightLabel].forEach {
                $0.removeFromSuperview()
                $0.isHidden = true
            }
        }
    }
}

// MARK: - UI 관련
extension BasicInformationViewContoller {
    private func addViews() {
        [mbtiLabelView, nameAgeLabel, locationLabel, locationImageView, heightLabel, heightImageView].forEach { view.addSubview($0) }
    }
    
    private func makeConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        mbtiLabelView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        nameAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabelView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(nameAgeLabel.snp.bottom).offset(15)
            make.leading.equalTo(safeArea)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.top)
            make.leading.equalTo(locationImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().priority(.low)
        }
        
        heightImageView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        heightLabel.snp.makeConstraints { make in
            make.top.equalTo(heightImageView.snp.top)
            make.leading.equalTo(heightImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().priority(.low)
        }
    }
}
