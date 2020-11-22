//
//  ArchitecturalProtocols.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import SwiftUI
import Combine

// MARK: - Application Layer
protocol Usecase {
    func next() -> Deferred<Future<Self, Error>>?
    func just(next: Self) -> Deferred<Future<Self, Error>>
    
    /// Usecaseに準拠するenumを引数に取り、再帰的にnext()を実行します。
    ///
    /// - Parameter contexts: ユースケースシナリオの（画面での分岐を除く）分岐をけcaseに持つenumのある要素
    /// - Returns: 引数のenumと同様のenumで、引数の分岐を処理した結果の要素
    func interact() -> Deferred<Future<[Self], Error>>
}

// MARK: - Presentation Layer
protocol RoutingFrom where To.From == Self {
    associatedtype To: UserInterface
    var view: To { get }
}

// MARK: Presenter by class
protocol Presentation: ObservableObject {}

// MARK: View by struct
protocol UserInterface {
    associatedtype From: RoutingFrom
    
    var from: From { get }
    
    init(from: From)
}

// MARK: - Extensions

extension Usecase {
    func just(next: Self) -> Deferred<Future<Self, Error>> {
        return Deferred {
            Future<Self, Error> { promise in
                promise(.success(next))
            }
        }
    }
    
    private func exec(contexts: [Self]) -> Deferred<Future<[Self], Error>> {
        guard let context = contexts.last else { fatalError() }
        
        // 終了条件
        guard let future = context.next() else {
            return Deferred {
                Future<[Self], Error> { promise in
                    promise(.success(contexts))
                }
            }
        }
        
        // 再帰呼び出し
        return Deferred {
            Future<[Self], Error> { promise in
                _ = future.sink { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                } receiveValue: { nextContext in
                    var _contexts = contexts
                    _contexts.append(nextContext)
                    
                    _ = self.exec(contexts: _contexts)
                        .sink { completion in
                            if case .failure(let error) = completion {
                                promise(.failure(error))
                            }
                        } receiveValue: { scenario in
                            promise(.success(scenario))
                        }
                }
            }
        }
    }
    
    func interact() -> Deferred<Future<[Self], Error>> {
        return self.exec(contexts: [self])
    }
}

extension RoutingFrom {
    var view: To {
        To(from: self)
    }
}
