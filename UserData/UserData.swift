import Foundation

class UserData: ObservableObject {
    @Published var users: [User] = []
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    private let endpoint = "/users"

    func fetchUsers() async {
        guard let url = URL(string: baseUrl + endpoint) else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            
            DispatchQueue.main.async {
                self.users = decodedUsers
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
