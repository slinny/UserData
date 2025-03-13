import SwiftUI
import SwiftData

struct UserListView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = UserData() // Initialize without modelContext for now
    @Query(sort: [SortDescriptor(\User.id)]) private var users: [User]
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Text(user.name)
                    }
                }
                .navigationBarTitle("Users")
            }
        }
        .task {
            viewModel.setModelContext(modelContext)
            await fetchData()
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.error != nil },
            set: { _ in viewModel.error = nil }
        )) {
            Text(viewModel.error?.localizedDescription ?? "")
        }
    }
    
    func fetchData() async {
        await viewModel.fetchAndSaveUsers()
    }
}

#Preview {
    UserListView()
}
