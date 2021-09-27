SwiftUIBoilerplate
==============

This boilerplate is oriented to the Clean Architecture.

# Usecase driven

1. Write a usecase as an enum.
2. Set the first action at the init.
3. Define relations of actions to others.
4. Each action calls Domain-models' functions. Don't implement domain logic here.

```swift

// Write a usecase as an enum
enum Boot : Usecase {
    /* basic course */
    case アプリはユーザがチュートリアル完了の記録がないかを調べる
    case チュートリアル完了の記録がある場合_アプリはログイン画面を表示
    
    /* alternative course */
    case チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示
    
    // Set the first action at the init.
    init() {
        self = .アプリはユーザがチュートリアル完了の記録がないかを調べる
    }
    
    // Define relations of actions to others. 
    func next() -> AnyPublisher<Boot, Error>? {
        switch self {
        case .アプリはユーザがチュートリアル完了の記録がないかを調べる:
            return self.detect()
            
        case .チュートリアル完了の記録がある場合_アプリはログイン画面を表示
             , .チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示:
            return nil
        }
    }
    
    // Each action calls Domain-models' functions. Don't implement domain logic here. 
    private func detect() -> AnyPublisher<Boot, Error> {
        return Deferred {
            Future<Boot, Error> { promise in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    if Application().hasCompletedTutorial {
                        promise(.success(.チュートリアル完了の記録がある場合_アプリはログイン画面を表示))
                    } else {
                        promise(.success(.チュートリアル完了の記録がない場合_アプリはチュートリアル画面を表示))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
```
