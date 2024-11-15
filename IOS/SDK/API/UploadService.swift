import Foundation
import Alamofire
import Dependencies
import _PhotosUI_SwiftUI

// MARK: - Protocol

enum UploadServiceError: Error {
    case photosItemEmpty
    case imageConversionFailed
}

public protocol IUploadService {
    
    /// Post /upload/thumb
    func uploadThumb(image: UIImage) async throws -> URL
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var uploadService: any IUploadService {
        get { self[UploadServiceKey.self] }
        set { self[UploadServiceKey.self] = newValue }
    }
    
    enum UploadServiceKey: DependencyKey {
        public static let liveValue: IUploadService = UploadService()
    }
}

// MARK: - Live

struct UploadService: IUploadService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func uploadThumb(image: UIImage) async throws -> URL {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            throw UploadServiceError.imageConversionFailed
        }
        
        let fileExtension = "jpg"
        let mimeType = "image/jpeg"
        //TODO: Стоит сделать зависимой от объекта к которому прикрепляется так как эта сможет нам сохранить чутка памяти на Cloud Storage
        let fileName = "\(UUID().uuidString).\(fileExtension)"
        
        return try await requestsService
            .upload(
                path: "/v1/upload/thumb",
                fileName: fileName,
                data: data,
                mimeType: mimeType
            )
            .serializingDecodable(URL.self)
            .value
    }
}
