//
//  CompleteTutorial.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/22.
//

import Combine

/// ユースケース【チュートリアルを完了する】を実現します。
enum CompleteTutorial : Usecase {
    case ユーザはチュートリアルを閉じる
    case アプリはチュートリアル完了を記録する
    case アプリはログイン画面を表示する
    
    init() {
        self = .ユーザはチュートリアルを閉じる
    }
    
    private func save() -> Deferred<Future<CompleteTutorial, Error>> {
        return Deferred {
            Future<CompleteTutorial, Error> { promise in
                Application().hasCompletedTutorial = true
                promise(.success(.アプリはログイン画面を表示する))
            }
        }
    }
    
    func next() -> Deferred<Future<CompleteTutorial, Error>>? {
        switch self {
        case .ユーザはチュートリアルを閉じる:
            return self.just(next: .アプリはチュートリアル完了を記録する)
            
        case .アプリはチュートリアル完了を記録する:
            return self.save()
            
        case .アプリはログイン画面を表示する:
            return nil
        }
    }
}
