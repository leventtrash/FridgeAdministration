import Foundation
import UserNotifications
class FoodItemStore {
    static let shared = FoodItemStore()
    private let userDefaults = UserDefaults.standard
    private let foodItemsKey = "foodItems"
    
    private init() {}
    
    // Alle Lebensmittel laden
    func loadFoodItems() -> [FoodItem] {
        guard let data = userDefaults.data(forKey: foodItemsKey) else { return [] }
        
        do {
            return try JSONDecoder().decode([FoodItem].self, from: data)
        } catch {
            print("Fehler beim Laden der Lebensmittel: \(error)")
            return []
        }
    }
    
    // Lebensmittel speichern
    func saveFoodItems(_ foodItems: [FoodItem]) {
        do {
            let data = try JSONEncoder().encode(foodItems)
            userDefaults.set(data, forKey: foodItemsKey)
        } catch {
            print("Fehler beim Speichern der Lebensmittel: \(error)")
        }
    }
    
    // Ein Lebensmittel hinzufügen
    func addFoodItem(_ item: FoodItem) {
        var items = loadFoodItems()
        items.append(item)
        saveFoodItems(items)
        scheduleNotification(for: item)
    }
    
    // Ein Lebensmittel aktualisieren
    func updateFoodItem(_ item: FoodItem) {
        var items = loadFoodItems()
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item
            saveFoodItems(items)
            scheduleNotification(for: item)
        }
    }
    
    // Ein Lebensmittel löschen
    func deleteFoodItem(with id: UUID) {
        var items = loadFoodItems()
        items.removeAll { $0.id == id }
        saveFoodItems(items)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    
    // Benachrichtigung für ablaufende Produkte planen
    private func scheduleNotification(for item: FoodItem) {
        let content = UNMutableNotificationContent()
        content.title = "Lebensmittel läuft bald ab"
        content.body = "\(item.name) läuft in 2 Tagen ab."
        content.sound = UNNotificationSound.default
        
        // Benachrichtigung 2 Tage vor Ablauf
        if let notificationDate = Calendar.current.date(byAdding: .day, value: -2, to: item.expiryDate) {
            let components = Calendar.current.dateComponents([.year, .month, .day], from: notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: item.id.uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}
