//
//  SafelyCodable.swift
//  
//
//  Created by Dmitriy Zharov on 24.08.2021.
//

import Foundation

/**
 Стандартное кодирование и безопасное декодирование данных.
 
 - Author: Дмитрий Жаров
 */
public typealias SafelyCodable = Encodable & SafelyDecodable
