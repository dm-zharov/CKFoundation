//
//  Data+MD5.swift
//
//
//  Created by Dmitriy Zharov on 31.05.2021.
//
//

import Foundation
import CryptoKit

public extension Data {
    /// Контрольная сумма данных.
    var md5Checksum: String {
        let digest = Insecure.MD5.hash(data: self)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
