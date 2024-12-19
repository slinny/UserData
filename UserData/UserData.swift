import Foundation
import Combine

class UserData: ObservableObject {
    @Published var users: [User] = []
    @Published var error: Error?
    private let baseUrl = "https://jsonplaceholder.typicode.com"
    private let endpoint = "/users"
    private var cancellables: Set<AnyCancellable> = []
    
    @MainActor
    func fetchUsers() async {
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            self.error = URLError(.badURL)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.error = URLError(.badServerResponse)
                return
            }

            guard let decodedUsers = try? JSONDecoder().decode([User].self, from: data) else {
                self.error = URLError(.cannotDecodeRawData)
                return
            }

            users = decodedUsers
        } catch {
            self.error = error
        }
    }
    
    func fetchUsersaa() async {
        guard let url = URL(string: baseUrl + endpoint) else {
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            
            // ???
            self.users = decodedUsers
            //            DispatchQueue.main.async {
            //                self.users = decodedUsers
            //            }
        } catch {
            // handle error with alert ???
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func fetchUsersCombine() {
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
    
    func fetchusersCombine2() {
        guard let url = URL(string: baseUrl + endpoint) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                // Handle response here
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
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


