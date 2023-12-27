import Foundation
import Combine

class UserData: ObservableObject {
    @Published var users: [User] = []
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    private let endpoint = "/users"
    private var cancellables: Set<AnyCancellable> = []
    
    
    func fetchUsers() {
        guard let url = URL(string: baseUrl + endpoint) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}
