# Документация Appointment API

Эта папка содержит визуальные схемы для методов работы с записями (Appointments).

## Схемы

### EndDate.jpg
Визуальная схема для метода `EmployeeAPI.Appointment.Parameters.All.ByDates`

Показывает как работает получение записей с указанием диапазона дат (startDate - endDate).

**Соответствующий код:**
```swift
public extension EmployeeAPI.Appointment.Parameters.All {
    struct ByDates: Codable {
        public let startDate: Date
        public let endDate: Date
        public let clientId: UUID?
    }
}
```

### Reversed.jpg
Визуальная схема для метода `EmployeeAPI.Appointment.Parameters.All.ByPagination`

Показывает как работает пагинация записей с возможностью реверсивного порядка (для загрузки прошлых записей).

**Соответствующий код:**
```swift
public extension EmployeeAPI.Appointment.Parameters.All {
    struct ByPagination: Codable {
        public let startDate: Date
        public let clientId: UUID?
        public var pagination: Pagination
        public let reversed: Bool  // maybe paginated in past
    }
}
```

## Примечание
Эти файлы используются только для документации разработчиков и не включаются в сборку пакета.

