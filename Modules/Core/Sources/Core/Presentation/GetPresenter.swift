//
//  File.swift
//  
//
//  Created by Alfa Centaury on 08/12/21.
//

import Combine
import Foundation

public class GetPresenter<Request, Response, Interactor: UseCase>
where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    private let _useCase: Interactor
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getPresenter(request: Request?,
                             receiveCompletion: @escaping (Subscribers.Completion<Error>) -> Void,
                             receiveValue: @escaping (Response) -> Void) {
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                receiveCompletion(completion)
            },
                  receiveValue: { result in
                receiveValue(result)
            })
            .store(in: &cancellables)
    }
}
