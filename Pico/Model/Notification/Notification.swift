//
//  Notification.swift
//  Pico
//
//  Created by 최하늘 on 2023/09/25.
//

import UIKit

// struct Notification: Codable {
//    let userId: String
//    let isNotification: Bool
//    let notiInfos: [NotiInfo]
//    
//    struct NotiInfo: Codable {
//        var id: String = UUID().uuidString
//        let notiType: NotiType
//        let sendUserId: String
//        let notiDate: Double
//    }
// }

enum NotiType: String, Codable {
    case like
    case message
    case report
    case block
    
    var content: String {
        switch self {
        case .like:
            return "님이 좋아요를 누르셨습니다."
        case .message:
            return "님이 쪽지를 보냈습니다."
        case .report:
            return "님이 신고하셨습니다."
        case .block:
            return "님을 차단하였습니다."
        }
    }
    
    var iconSystemImageName: String {
        switch self {
        case .like:
            return "heart.fill"
        case .message:
            return "message.fill"
        case .report:
            return "exclamationmark.bubble.fill"
        case .block:
            return "exclamationmark.bubble.fill"
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .like:
            return .systemPink
        case .message:
            return .picoBlue
        case .report:
            return .systemRed
        case .block:
            return .systemOrange
        }
    }
}

struct Noti: Codable {
    let receiveId: String // 알림 받는 사람 id
    let name: String // 보내는사람 이름
    let birth: String // 보내는사람 생년월일
    let imageUrl: String // 보내는 사람 첫번째 이미지
    let notiType: NotiType
    let mbti: MBTIType // 보내는 사람 mbti
    let createDate: Double // 알림 보낸 시간
    
    var age: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let birthdate = birth.toDate()
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: currentDate)
        return ageComponents.year ?? 0
    }
}
