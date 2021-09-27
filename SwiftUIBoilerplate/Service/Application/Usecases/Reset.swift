//
//  Reset.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/22.
//

import Combine

/// ユースケース【アプリをリセットする】を実現します。
enum Reset : Usecase {
    case アプリは設定情報をクリアする
    case アプリは結果を表示する(isSuccess: Bool)
    
    init() {
        self = .アプリは設定情報をクリアする
    }
    
    func next() -> AnyPublisher<Reset, Error>? {
        switch self {
        case .アプリは設定情報をクリアする:
            return self.reset()
        case .アプリは結果を表示する:
            return nil
        }
    }
    
    private func reset() -> AnyPublisher<Reset, Error> {
        return Deferred {
            Future<Reset, Error> { promise in
                promise(.success(.アプリは結果を表示する(isSuccess: Application().reset())))
            }
        }
        .eraseToAnyPublisher()
    }
}

