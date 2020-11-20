//
//  Identificator.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/19.
//

import Combine

protocol IdentificationUsecase: Usecase {
    /// ユースケース【アプリを起動する】を実現します。
    ///
    /// - Returns: 実行結果のコンテキスト
    func boot() -> Deferred<Future<[Boot], Error>>
    
    
    /// ユースケース【チュートリアルを完了する】を実現します。
    func completeTutorial() -> Deferred<Future<[CompleteTutorial], Error>>
    
    /// ユースケース【アプリをリセットする】を実現します。
    ///
    /// - Returns: 実行結果のコンテキスト
    func reset() -> Deferred<Future<[Reset], Error>>
}

enum Boot : Scenario {
    case アプリはユーザがチュートリアル完了の記録がないかを調べる
    case チュートリアル完了の記録がある場合
    case チュートリアル完了の記録がない場合
    
    init() {
        self = .アプリはユーザがチュートリアル完了の記録がないかを調べる
    }
    
    private func detect() -> Deferred<Future<Boot, Error>> {
        return Deferred {
            Future<Boot, Error> { promise in
                if Application().hasCompletedTutorial {
                    promise(.success(.チュートリアル完了の記録がある場合))
                } else {
                    promise(.success(.チュートリアル完了の記録がない場合))
                }
            }
        }
    }
    
    func next() -> Deferred<Future<Boot, Error>>? {
        switch self {
        case .アプリはユーザがチュートリアル完了の記録がないかを調べる:
            return self.detect()
        
        case .チュートリアル完了の記録がある場合
             , .チュートリアル完了の記録がない場合:
            return nil
        }
    }
}

enum CompleteTutorial : Scenario {
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
            return self.next(scenario: .アプリはチュートリアル完了を記録する)
            
        case .アプリはチュートリアル完了を記録する:
            return self.save()
        
        case .アプリはログイン画面を表示する:
            return nil
        }
    }
}

enum Reset : Scenario {
    case アプリは設定情報をクリアする
    case アプリは結果を表示する(isSuccess: Bool)
    
    init() {
        self = .アプリは設定情報をクリアする
    }
    
    private func reset() -> Deferred<Future<Reset, Error>> {
        return Deferred {
            Future<Reset, Error> { promise in
                promise(.success(.アプリは結果を表示する(isSuccess: Application().reset())))
            }
        }
    }
    
    func next() -> Deferred<Future<Reset, Error>>? {
        switch self {
        case .アプリは設定情報をクリアする:
            return self.reset()
        case .アプリは結果を表示する:
            return nil
        }
    }
}

struct Identificator: IdentificationUsecase {
    
    func boot() -> Deferred<Future<[Boot], Error>> {
        return self.interact(contexts: [Boot()])
    }
    
    func completeTutorial() -> Deferred<Future<[CompleteTutorial], Error>> {
        return self.interact(contexts: [CompleteTutorial()])
    }
    
    func reset() -> Deferred<Future<[Reset], Error>> {
        return self.interact(contexts: [Reset()])
    }
    
}


