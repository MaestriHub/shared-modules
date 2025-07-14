import Foundation

func defaultURLDateEncode() -> (Date) throws -> String? {
    URLDateEncode(DateFormatter.iso8601, .millisecondsAndSeconds)
}

func URLDateEncode(_ formatter: ISO8601DateFormatter, _ kDefaultPresicion: Date.RoundingPrecision) -> (Date) -> String? {
    return { date in
        let formattedDate = date.rounded(kDefaultPresicion)
        var dateString = formatter.string(from: formattedDate)
        return dateString
    }
}
