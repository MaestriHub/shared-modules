import Foundation

public enum MarketingCampaign {
    public enum Parameters {}
    public enum Responses {}
}

public extension MarketingCampaign.Parameters {
    
    struct Create: Codable, Sendable {
        public let salonId: UUID
        public let type: CampaignType
        public let name: String
        public let description: String?
        public let affiliateOfferId: UUID?
        public let influencerContactId: UUID?
        
        public init(
            salonId: UUID,
            type: CampaignType,
            name: String,
            description: String? = nil,
            affiliateOfferId: UUID? = nil,
            influencerContactId: UUID? = nil
        ) {
            self.salonId = salonId
            self.type = type
            self.name = name
            self.description = description
            self.affiliateOfferId = affiliateOfferId
            self.influencerContactId = influencerContactId
        }
    }
    
    struct Update: Codable, Sendable {
        public let name: String?
        public let description: String?
        
        public init(name: String? = nil, description: String? = nil) {
            self.name = name
            self.description = description
        }
    }
}

public extension MarketingCampaign.Responses {
    
    struct Full: Codable, Sendable {
        public let id: UUID
        public let salonId: UUID
        public let type: CampaignType
        public let name: String
        public let description: String?
        public let linkId: String?
        public let affiliateOfferId: UUID?
        public let influencerContactId: UUID?
        public let clicksCount: Int?
        public let appointmentsCreated: Int?
        public let createdAt: Date?
        public let updatedAt: Date?
        
        public init(
            id: UUID,
            salonId: UUID,
            type: CampaignType,
            name: String,
            description: String? = nil,
            linkId: String? = nil,
            affiliateOfferId: UUID? = nil,
            influencerContactId: UUID? = nil,
            clicksCount: Int? = nil,
            appointmentsCreated: Int? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.salonId = salonId
            self.type = type
            self.name = name
            self.description = description
            self.linkId = linkId
            self.affiliateOfferId = affiliateOfferId
            self.influencerContactId = influencerContactId
            self.clicksCount = clicksCount
            self.appointmentsCreated = appointmentsCreated
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
    
    struct Details: Codable, Sendable {
        public let campaignId: UUID
        public let name: String
        public let type: CampaignType
        public let linkId: String?
        public let clicksCount: Int
        public let appointmentsCreated: Int
        public let clicksByDay: [Date: Int]?
        public let appointmentsByDay: [Date: Int]?
        public let createdAt: Date?
        
        public init(
            campaignId: UUID,
            name: String,
            type: CampaignType,
            linkId: String? = nil,
            clicksCount: Int,
            appointmentsCreated: Int,
            clicksByDay: [Date: Int]? = nil,
            appointmentsByDay: [Date: Int]? = nil,
            createdAt: Date? = nil
        ) {
            self.campaignId = campaignId
            self.name = name
            self.type = type
            self.linkId = linkId
            self.clicksCount = clicksCount
            self.appointmentsCreated = appointmentsCreated
            self.clicksByDay = clicksByDay
            self.appointmentsByDay = appointmentsByDay
            self.createdAt = createdAt
        }
    }
}

