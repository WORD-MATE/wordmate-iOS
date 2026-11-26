import SwiftUI

@main
struct WordMateApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StudentLoginView()
            }
            .tint(Color(red: 182 / 255, green: 227 / 255, blue: 35 / 255))
        }
    }
}
