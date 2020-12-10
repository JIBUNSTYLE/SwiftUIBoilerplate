//
//  SharedPresenter.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation
import Combine

class SharedPresenter: Presentation {
    
    @Published var routingTo: RoutingTo = .splash(from: .system)
    
    private var cancellables = [AnyCancellable]()
    
    func boot() {
        Boot()
            .interact()
            .sink { completion in
                if case .finished = completion {
                    log("boot は正常終了")
                } else if case .failure(let error) = completion {
                    log("boot が異常終了: \(error)")
                }
            } receiveValue: { scenario in
                log("usecase - boot: \(scenario)")
                
                if case .チュートリアル完了の記録がある場合_アプリはログイン画面を表示 = scenario.last {
                    self.routingTo = .login(from: .splash)

                } else if case .チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示 = scenario.last {
                    self.routingTo = .tutorial(from: .splash)
                }
            }.store(in: &cancellables)
    }
    
    func completeTutorial() {
        
        CompleteTutorial()
            .interact()
            .sink { completion in
                if case .finished = completion {
                    log("completeTutorial は正常終了")
                } else if case .failure(let error) = completion {
                    log("completeTutorial が異常終了: \(error)")
                }
            } receiveValue: { scenario in
                log("usecase - completeTutorial: \(scenario)")
                
                DispatchQueue.main.async {
                    guard case .アプリはログイン画面を表示する = scenario.last else { fatalError() }
                    self.routingTo = .login(from: .tutorial)
                }
            }.store(in: &cancellables)
    }
    
    func reset(handler: @escaping (Bool) -> Void) {
        Reset()
            .interact()
            .sink { completion in
                if case .finished = completion {
                    log("reset は正常終了")
                } else if case .failure(let error) = completion {
                    log("reset が異常終了: \(error)")
                }
            } receiveValue: { scenario in
                log("usecase - reset: \(scenario)")
                
                guard case .アプリは結果を表示する(let isSuccess) = scenario.last else {
                    fatalError()
                }
                handler(isSuccess)
            }.store(in: &cancellables)
    }
}
