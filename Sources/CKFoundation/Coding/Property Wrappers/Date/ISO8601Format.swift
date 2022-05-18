//
//  ISO8601Format.swift
//  
//
//  Created by Dmitriy Zharov on 21.12.2021.
//

import Foundation

/**
 Рекомендации по неймингу структур с реализацией данного протокола:
 
 ```
 ISO_LOCAL_DATE    ISO Local Date    '2011-12-03'
 ISO_OFFSET_DATE    ISO Date with offset    '2011-12-03+01:00'
 ISO_DATE    ISO Date with or without offset    '2011-12-03+01:00'; '2011-12-03'
 ISO_LOCAL_TIME    Time without offset    '10:15:30'
 ISO_OFFSET_TIME    Time with offset    '10:15:30+01:00'
 ISO_TIME    Time with or without offset    '10:15:30+01:00'; '10:15:30'
 ISO_LOCAL_DATE_TIME    ISO Local Date and Time    '2011-12-03T10:15:30'
 ISO_OFFSET_DATE_TIME    Date Time with Offset    2011-12-03T10:15:30+01:00'
 ISO_ZONED_DATE_TIME    Zoned Date Time    '2011-12-03T10:15:30+01:00[Europe/Paris]'
 ISO_DATE_TIME    Date and time with ZoneId    '2011-12-03T10:15:30+01:00[Europe/Paris]'
 ISO_ORDINAL_DATE    Year and day of year    '2012-337'
 ISO_WEEK_DATE    Year and Week    2012-W48-6'
 ISO_INSTANT    Date and Time of an Instant    '2011-12-03T10:15:30Z'
 RFC_1123_DATE_TIME    RFC 1123 / RFC 822    'Tue, 3 Jun 2008 11:05:30 GMT'
 ```
 */
public protocol ISO8601Format {
    static var options: ISO8601DateFormatter.Options { get }
}

/// Формат времени вида `yyyy-MM-dd` (`2011-12-03`)
public struct LocalDate: ISO8601Format {
    public static let options: ISO8601DateFormatter.Options = [
        .withFullDate,
        .withDashSeparatorInDate
    ]
}

/// Формат времени вида `yyyy-MM-dd'T'HH:mm:ss.SSSZ` (`2012-10-01T09:45:00.000+02:00`)
public struct ZonedDateTime: ISO8601Format {
    public static let options: ISO8601DateFormatter.Options = [
        .withFullDate,
        .withTime,
        .withFractionalSeconds,
        .withDashSeparatorInDate,
        .withColonSeparatorInTime
    ]
}
