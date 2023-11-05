import Foundation

/// Протокол `Parametable` определяет типы, которые могут быть использованы в качестве параметров запросов.
///
/// Типы, соответствующие этому протоколу, могут автоматически кодироваться и декодироваться из
/// тел запросов или строк запросов. Кроме того, они могут интегрироваться с системой валидации Vapor,
/// чтобы обеспечить проверку входящих данных перед их обработкой.
///
/// В контексте Vapor, структура, соответствующая `Parametable`, должна также соответствовать
/// `Validatable`, если требуется валидация данных до их использования. Это позволяет описать
/// правила валидации, которые Vapor применит автоматически при обработке запросов.
///
/// Пример использования:
///
///     struct MyParameters: Parametable, Validatable {
///         let name: String
///         let age: Int
///
///         static func validations(_ validations: inout Validations) {
///             validations.add("name", as: String.self, is: !.empty)
///             validations.add("age", as: Int.self, is: .range(18...))
///         }
///     }
///
/// Этот пример показывает структуру параметров, которая требует, чтобы `name` не был пустым,
/// и `age` был в диапазоне от 18 и выше.
///
public protocol Parametable: Codable {}

/// Пример интеграции:
/// ```
///     import Vapor
///
///     // Для Vapor мы можем автоматически заставить все структуры, которые поддерживают Parametable, также поддерживать Validatable.
///     extension Parametable where Self: Validatable {
///         // Теперь каждый Parametable автоматически становится и Validatable в контексте Vapor.
///     }
///
///     // Пример расширения конкретной структуры, чтобы она поддерживала Validatable
///     extension MyParameters: Validatable {
///         static func validations(_ validations: inout Validations) {
///             // Определение правил валидации для параметров
///         }
///     }
///```

