import Foundation

public enum MagicLinkKind: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case employeeInvite  // Ссылка для приглашения сотрудника - искать в EmployeeModel.inviteLinkId
    case clientInvite    // Ссылка для приглашения клиента - искать в ClientModel.inviteLinkId
    case marketing       // Маркетинговая ссылка - искать в MarketingCampaign.linkNanoId
}

