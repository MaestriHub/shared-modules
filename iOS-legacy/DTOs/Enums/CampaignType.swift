import Foundation

public enum CampaignType: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case share       // Дефолтная кампания "Поделиться"
    case custom      // Которые создаёт пользователь
    case affiliate   // Кампания для конкретного инфлюенсера (связана с AffiliateOffer)
    case media       // Для социальных сетей
}

