import SwiftUI

@main
struct DifferApp: App {
    var body: some Scene {
        WindowGroup {
            WebView()
                .frame(minWidth: 720, minHeight: 480)
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .defaultSize(width: 1000, height: 680)
        .commands {
            CommandGroup(replacing: .newItem) { }
        }
    }
}
