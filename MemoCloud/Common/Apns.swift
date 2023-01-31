//
//  Apns.swift
//  MemoCloud
//
//  Created by Yuki Ono on 2023/01/16.
//

import Foundation
import UIKit

class Apns{
    static func dialogBox(vc:CommonViewController ,userInfo: [AnyHashable : Any]) -> Bool{
        vc.backgroundColor = .green
        vc.payloadText = userInfo
        return true
    }
}
