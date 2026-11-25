# WordMate iOS

WordMate의 iPhone 앱입니다. Swift와 SwiftUI를 사용하며 최소 지원 버전은 iOS 17.0입니다.

## 실행

1. Xcode에서 `WordMate.xcodeproj`를 엽니다. 확인 환경은 Xcode 27.2입니다.
2. 공유 스킴 `WordMate`와 iPhone 시뮬레이터를 선택합니다.
3. **Product → Run** 또는 `⌘R`로 실행합니다.

명령줄에서 시뮬레이터용 앱을 빌드할 수 있습니다.

```sh
xcodebuild -project WordMate.xcodeproj -scheme WordMate -destination 'generic/platform=iOS Simulator' build
```
