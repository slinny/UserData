import SwiftUI
import SwiftData

@main
struct UserDataApp: App {
    
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
        .modelContainer(for: User.self)
    }
}
