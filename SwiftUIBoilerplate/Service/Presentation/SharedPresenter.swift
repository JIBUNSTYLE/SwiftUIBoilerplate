//
//  SharedPresenter.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Foundation

class SharedPresenter: Presentation {
    
    @Published var current: RoutingTo = .splash(from: .system)
    
    func boot() {
        _ = Identificator()
            .boot()
            .sink { completion in
                if case .finished = completion {
                    log("boot は正常終了")
                } else if case .failure(let error) = completion {
                    log("boot が異常終了: \(error)")
                }
            } receiveValue: { scenario in
                log("usecase - boot: \(scenario)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if case .チュートリアル完了の記録がある場合 = scenario.last {
                        self.current = .login(from: .splash)
                        
                    } else if case .チュートリアル完了の記録がない場合 = scenario.last {
                        self.current = .tutorial(from: .splash)
                    }
                }
            }
    }
    
    func completeTutorial() {
        
        _ = Identificator()
            .completeTutorial()
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
                    self.current = .login(from: .tutorial)
                }
            }
    }
    
    func reset(handler: @escaping (Bool) -> Void) {
        _ = Identificator()
            .reset()
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
            }
    }
}
