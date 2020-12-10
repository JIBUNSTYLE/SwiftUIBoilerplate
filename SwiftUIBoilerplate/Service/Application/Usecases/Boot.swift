//
//  Boot.swift
//  SwiftUIBoilerplate
//
//  Created by 斉藤 祐輔 on 2020/11/22.
//

import Foundation
import Combine

/// ユースケース【アプリを起動する】を実現します。
enum Boot : Usecase {
    /* 基本コース */
    case アプリはユーザがチュートリアル完了の記録がないかを調べる
    case チュートリアル完了の記録がある場合_アプリはログイン画面を表示
    
    /* 代替コース */
    case チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示
    
    init() {
        self = .アプリはユーザがチュートリアル完了の記録がないかを調べる
    }
    
    private func detect() -> Deferred<Future<Boot, Error>> {
        return Deferred {
            Future<Boot, Error> { promise in
                // Futureが非同期になる場合、sinkする側ではcancellableをstoreしておかないと、
                // 非同期処理が終わる前にsubsciptionはキャンセルされてしまうので注意
                // @see: https://forums.swift.org/t/combine-future-broken/28560/2
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if Application().hasCompletedTutorial {
                        promise(.success(.チュートリアル完了の記録がある場合_アプリはログイン画面を表示))
                    } else {
                        promise(.success(.チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示))
                    }
                }
            }
        }
    }
    
    func next() -> Deferred<Future<Boot, Error>>? {
        switch self {
        case .アプリはユーザがチュートリアル完了の記録がないかを調べる:
            return self.detect()
            
        case .チュートリアル完了の記録がある場合_アプリはログイン画面を表示
             , .チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示:
            return nil
        }
    }
}
