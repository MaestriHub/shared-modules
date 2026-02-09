import Foundation

public enum Product {

    public enum Unit: String, Codable, CaseIterable {
        case milliliters
        case grams
        case pieces
    }

    public enum TaxProfile: String, Codable, CaseIterable {
        case none
        case vat10
        case vat20
    }

    public enum Parameters {

        public struct All: Encodable {
            public var search: String?
            public var categoryFilter: String?
            public var brandFilter: String?
            public var supplierFilter: String?
            public var inStockOnly: Bool?
            public var pagination: Pagination?
        }

        public struct Create: Encodable {
            public var title: String
            public var barcode: String?
            public var brand: String?
            public var category: String?
            public var unit: Unit
            public var amount: Decimal?
            public var shortDescription: String?
            public var description: String?

            public var photos: [URL]
            public var primaryImageIndex: Int

            public var pricing: Pricing
            public var commission: Commission
            public var inventory: Inventory
            public var stock: Stock
        }

        public struct Update: Encodable {
            public var title: String?
            public var barcode: String?
            public var brand: String?
            public var category: String?
            public var unit: Unit?
            public var amount: Decimal?
            public var shortDescription: String?
            public var description: String?

            public var photos: [URL]?
            public var primaryImageIndex: Int?

            public var pricing: Pricing?
            public var commission: Commission?
            public var inventory: Inventory?
            public var stock: Stock?
        }

        public struct Pricing: Codable {
            public var supplyPrice: Price
            public var retailEnabled: Bool
            public var retailPrice: Price
            public var taxProfile: TaxProfile
        }

        public struct Commission: Codable {
            public var enabled: Bool
            public var percent: Decimal?
        }

        public struct Inventory: Codable {
            public var sku: String
            public var additionalSkus: [String]
            public var supplier: String?
        }

        public struct Stock: Codable {
            public var trackingEnabled: Bool
            public var quantity: Int
            public var lowStockEnabled: Bool
            public var lowStockThreshold: Int?
            public var reorderQuantity: Int?
            public var lowStockNotificationEnabled: Bool
        }
    }

    public enum Responses {
        public typealias All = [Helpers.ProductResponse]
        public typealias Retrieve = Helpers.ProductResponse
        public typealias Create = Helpers.ProductResponse
        public typealias Update = Helpers.ProductResponse
        public typealias Options = Helpers.OptionsResponse
        public typealias StockAdjustments = [Helpers.StockAdjustmentResponse]
    }

    public enum Helpers {
        public struct ProductResponse: Codable, Identifiable {
            public var id: UUID
            public var title: String
            public var barcode: String?
            public var brand: String?
            public var category: String?
            public var unit: Unit
            public var amount: Decimal?
            public var shortDescription: String?
            public var description: String?

            public var photos: [URL]
            public var primaryImageIndex: Int

            public var pricing: Parameters.Pricing
            public var commission: Parameters.Commission
            public var inventory: Parameters.Inventory
            public var stock: Parameters.Stock

            public var marginPercent: Decimal
            public var totalRetailAmount: Decimal
            public var totalSupplyAmount: Decimal
            public var averageCostAmount: Decimal

            public var createdAt: Date
            public var updatedAt: Date
        }

        public struct OptionsResponse: Codable {
            public var brands: [String]
            public var categories: [String]
            public var suppliers: [String]
            public var taxProfiles: [TaxProfile]
            public var units: [Unit]
        }

        public struct StockAdjustmentResponse: Codable, Identifiable {
            public var id: UUID
            public var productId: UUID
            public var delta: Int
            public var reason: String?
            public var balanceAfter: Int
            public var createdAt: Date
            public var createdBy: UUID?
        }
    }
}
