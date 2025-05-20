import SwiftUI

struct SettingsView: View {
    @AppStorage("notifyBeforeExpiration") private var notifyBeforeExpiration = true
    @AppStorage("daysBeforeNotification") private var daysBeforeNotification = 7
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Benachrichtigungen")) {
                    Toggle("Vor Ablauf benachrichtigen", isOn: $notifyBeforeExpiration)
                    
                    if notifyBeforeExpiration {
                        Stepper("\(daysBeforeNotification) Tage vorher", value: $daysBeforeNotification, in: 1...30)
                    }
                }
                
                Section(header: Text("Über")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Einstellungen")
        }
    }
}

#Preview {
    SettingsView()
} 