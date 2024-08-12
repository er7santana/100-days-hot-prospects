//
//  ShaftConnector.swift
//  HotProspects
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 11/08/24.
//

import Foundation

class ShaftConnector: NSObject {
    private lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    private let certificates: [Data] = {
        let url = Bundle.main.url(forResource: "certadmin", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
    }()
    
    let pinnedCertificates: [SecCertificate] = {
        let pinnedCertificateData = try! Data(contentsOf: Bundle.main.url(forResource: "certadmin", withExtension: "cer")!)
        let pinnedCertificates = [SecCertificateCreateWithData(nil, pinnedCertificateData as CFData)!]
        return pinnedCertificates
    }()
    
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: urlRequest)
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await session.data(from: url)
    }
}

extension ShaftConnector: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
//        guard let serverTrust = challenge.protectionSpace.serverTrust else {
//            return
//        }
//        
//        completionHandler(.useCredential, URLCredential(trust: serverTrust))
//        return
        do {
            guard let serverTrust = challenge.protectionSpace.serverTrust else {
                throw PortalCertificateLoaderError.cantGetServerTrust
            }
            
            guard self.isTrustful(space: challenge.protectionSpace) else {
                throw PortalCertificateLoaderError.cantPinCertificateTrust
            }
            
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: serverTrust))
            
        } catch {
            completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
            print(error)
        }
    }
    
    
     func isTrustful(space: URLProtectionSpace) -> Bool {
         guard let serverTrust = space.serverTrust else { return false }
         let certs = self.certificates.compactMap({ SecCertificateCreateWithData(nil, $0 as CFData) })
         
         // Establish a chain of trust anchored on our bundled certificate.
         SecTrustSetAnchorCertificates(serverTrust, certs as NSArray)
         
         // Verify that trust
         guard var result = SecTrustResultType(rawValue: 0) else { return false }
         
         SecTrustEvaluate(serverTrust, &result)
         
         var allowedResults: [SecTrustResultType] = [.unspecified, .proceed]
         
//         if allowSelfSignedCertificate {
//             allowedResults.append(.recoverableTrustFailure)
//         }
         
         return allowedResults.contains(result)
     }
}

enum PortalCertificateLoaderError: String, LocalizedError {
    case notFoundCertificate = "O certificado com o nome especificado não foi encontrado"
    case cantGetServerTrust = "Falha ao receber dados do desafio HTTPS"
    case cantPinCertificateTrust = "Falha na pinagem com certificado HTTPS"
    
    var errorDescription: String? {
        return self.rawValue
    }
}
