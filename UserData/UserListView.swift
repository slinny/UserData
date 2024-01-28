import SwiftUI
import SwiftData

struct UserListView: View {
    
    @StateObject private var viewModel = UserData()
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\User.id)]) private var users: [User]
    
    var body: some View {
        
        NavigationStack {
            List(users) { user in
                NavigationLink(destination: UserDetailView(user: user)) {
                    Text(user.name)
                }
            }
            .navigationBarTitle("Users")
        }
        .task {
            await fetchData()
        }
    }
    
    func fetchData() async {
        await viewModel.fetchUsers()

        let batchSize = 10
        let totalObjects = viewModel.users.count

        for i in 0..<(totalObjects / batchSize) {
            for j in 0..<batchSize {
                let user = viewModel.users[i * batchSize + j]
                modelContext.insert(user)
            }
            do {
                try modelContext.save()
            } catch {
                print("Error Saving Data into Container")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        return UserListView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
