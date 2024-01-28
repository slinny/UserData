import SwiftUI
import SwiftData

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        List {
            Section(header: Text("Personal Information")) {
                Text("Name: \(user.name)")
                Text("Username: \(user.username)")
                Text("Email: \(user.email)")
            }
            
            Section(header: Text("Address")) {
                Text("Street: \(user.address.street)")
                Text("Suite: \(user.address.suite)")
                Text("City: \(user.address.city)")
                Text("Zipcode: \(user.address.zipcode)")
            }
            
            Section(header: Text("Geo Location")) {
                Text("Latitude: \(user.address.geo.lat)")
                Text("Longitude: \(user.address.geo.lng)")
            }
            
            Section(header: Text("Contact")) {
                Text("Phone: \(user.phone)")
                Text("Website: \(user.website)")
            }
            
            Section(header: Text("Company")) {
                Text("Name: \(user.company.name)")
                Text("Catch Phrase: \(user.company.catchPhrase)")
                Text("Business: \(user.company.bs)")
            }
        }
        .listStyle(GroupedListStyle())
    }
}
