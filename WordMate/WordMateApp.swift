import SwiftUI

@main
struct WordMateApp: App {
    var body: some Scene {
        WindowGroup {
            Text("WordMate")
                .font(.title)
                .accessibilityAddTraits(.isHeader)
        }
    }
}
