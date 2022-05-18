//
//  Data+CompressJPEGImage.swift
//
//
// Created by Dmitriy Zharov on 15.03.2021.
//

#if os(iOS)

import UIKit

public extension Data {
    /// Сжатие изображения до целевого размера в байтах.
    /// - Parameters:
    ///   - sizeLimitBytes: Целевой размер изображения в байтах.
    ///   - maxCompressionQuality: Начальный уровень сжатия, от которого алгоритм будет отталкиваться в сторону подгонки размера изображения до целевого.
    /// - Returns: Сжатое до целевого размера изображение.
    func compressJPEGImage(sizeLimitBytes: Int, maxCompressionQuality: CGFloat) -> Data? {
        var compressionQuality = maxCompressionQuality

        guard let image = UIImage(data: self) else { return nil }
        guard var imageData = image.jpegData(compressionQuality: compressionQuality) else { return nil }

        while imageData.count > sizeLimitBytes {
            compressionQuality -= 0.1
            guard let additionallyCompressedData = image.jpegData(compressionQuality: compressionQuality) else { return nil }
            imageData = additionallyCompressedData
        }
        
        return imageData
    }
}

#endif
