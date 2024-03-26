//
//  NetworkingRequester.swift
//  ApplaudoiOSChallenge01
//
//  Created by alexanderrivera on 28/8/23.
//

import Foundation
import Moya
import Combine

// MARK: - Networking Requester Type
protocol NetworkingRequesterType {
    func get<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error>
    func post<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error>
    func patch<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error>
    func delete(target: NetworkingTargetType) -> AnyPublisher<Bool, Error>
}

// MARK: - Networking Requester Implementation
struct NetworkingRequester: NetworkingRequesterType {
    // MARK: - Properties
    private let provider: MoyaProvider<MultiTarget>
    
    // MARK: - Initializer
    init(provider: MoyaProvider<MultiTarget> = .networkingProvider()) {
        self.provider = provider
    }
    
    // MARK: - Execute Functionality
    func get<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error> {
        Future { seal in
            provider.request(MultiTarget(target)) { result in
                do {
                    switch result {
                    case .success(let response):
                        let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                        seal(.success(decodedResponse))
                    case .failure(let error):
                        seal(.failure(error))
                    }
                } catch {
                    seal(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func post<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error> {
        Future { seal in
            self.provider.request(MultiTarget(target), callbackQueue: .main, progress: nil) { result in
                do {
                    switch result {
                    case .success(let response):
                        let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                        seal(.success(decodedResponse))
                    case .failure(let error):
                        seal(.failure(error))
                    }
                } catch {
                    seal(.failure(error))
                }
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    func patch<T: Decodable>(target: NetworkingTargetType) -> AnyPublisher<T, Error> {
        Future { seal in
            provider.request(MultiTarget(target)) { result in
                do {
                    switch result {
                    case .success(let response):
                        let decodedResponse = try JSONDecoder().decode(T.self, from: response.data)
                        seal(.success(decodedResponse))
                    case .failure(let error):
                        seal(.failure(error))
                    }
                } catch {
                    seal(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete(target: NetworkingTargetType) -> AnyPublisher<Bool, Error> {
        Future { seal in
            provider.request(MultiTarget(target)) { result in
                switch result {
                case .success(let response):
                    seal(.success(true))
                case .failure(let error):
                    seal(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
