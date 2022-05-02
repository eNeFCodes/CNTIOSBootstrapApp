//
//  RandomImageAPIService.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/19/22.
//

import Combine
import Foundation

class RandomImageAPIService: APIService {
    static let shared = RandomImageAPIService()

    private var subscriptions = Set<AnyCancellable>()

    func start() {
        Task {
            let publisher = await RandomImageAPIService.shared
                .request(api: RandomImageAPI.imageBy1000)

            publisher
                .sink(receiveCompletion: { c in
                    print("completion: ", c)
                }, receiveValue: { result in
                    switch result {
                    case .success(let data):
                        if let image = data as? RandomImage {
                            print("message: ", image.message)
                        }
                    default: break
                    }
                })
                .store(in: &subscriptions)
        }
    }

    func startMultiple() {
        Task {
            let publisher = await RandomImageAPIService.shared
                .request(apis: [RandomImageAPI.imageBy2000, RandomImageAPI.imageBy3000])

            publisher
                .sink(receiveCompletion: { c in
                    print("multile completion: ", c)
                }, receiveValue: { result in
                    switch result {
                    case .success(let data):
                        if let image = data as? RandomImage {
                            print("multile message: ", image.message)
                        }
                    default: break
                    }
                })
                .store(in: &subscriptions)
        }
    }
}

