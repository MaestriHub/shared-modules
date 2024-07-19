import Foundation

public enum OperationType: String, Codable, Hashable, Equatable {
    case cashIn // внесение налички
    case unrecorded // неучтенка
    case bonus // премия
    case salary // зарплата
    case appointment //
}
