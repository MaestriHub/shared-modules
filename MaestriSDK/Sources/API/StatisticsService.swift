//
//  StatisticsService.swift
//  Created by Vitaliy Shevtsov on 4/4/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IStatisticsService {
    
    /// GET /statistics/appointments/&type=all,salon,master
    /// Передаю type для получение кол-во записей по данному мастеру или салону либо по всем салонам одного владельца
    /// Возможно лучше вынести в отдельный сервес типо Statistic который потом мы будем нагужать доп статистикой
    func appointmentsStatistic(parameters: Statistic.Parameters.AppointmentsQuery) async throws -> Statistic.Responses.Appointments
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var statisticsService: any IStatisticsService {
        get { self[StatisticsServiceKey.self] }
        set { self[StatisticsServiceKey.self] = newValue }
    }
    
    enum StatisticsServiceKey: DependencyKey {
        public static let liveValue: IStatisticsService = StatisticsService()
    }
}

//MARK: - Live

public final class StatisticsService: IStatisticsService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func appointmentsStatistic(parameters: Statistic.Parameters.AppointmentsQuery) async throws -> Statistic.Responses.Appointments {

        try await requestsService
            .request(
                path: "/v1/statistics/appointments",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(Statistic.Responses.Appointments.self, decoder: decoderService.jsonDecoder)
            .value
    }
}
