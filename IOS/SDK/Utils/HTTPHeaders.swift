import Alamofire

// MARK: Requester-Type

extension HTTPHeaders {
    
    public var requesterType: RequesterType? {
        get {
            guard let string = self.value(for: "Requester-Type") else {
                return nil
            }
            return RequesterType(rawValue: string)
        }
        set {
            if let type = newValue {
                update(HTTPHeader(name: "Requester-Type", value: type.rawValue))
            } else {
                remove(name: "Requester-Type")
            }
        }
    }
}

// MARK: Device-ID

extension HTTPHeaders {
    
    public var deviceId: String? {
        get {
            return value(for: "Device-ID")
        }
        set {
            if let newValue {
                update(HTTPHeader(name: "Device-ID", value: newValue))
            } else {
                remove(name: "Device-ID")
            }
        }
    }
}
