import Foundation

func defaultURLDateEncoder() -> (Date) throws -> String? {
    URLDateEncoder(DateFormatter.iso8601, .millisecondsAndSeconds)
}

func URLDateEncoder(_ formatter: ISO8601DateFormatter, _ kDefaultPresicion: Date.RoundingPrecision) -> (Date) -> String? {
    return { date in
        let formattedDate = date.rounded(kDefaultPresicion)
        
        var dateString = formatter.string(from: formattedDate)
        dateString.replace(":", with: "%3A")
        
        return dateString
    }
}
