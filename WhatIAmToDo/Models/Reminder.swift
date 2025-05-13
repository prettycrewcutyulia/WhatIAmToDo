import Foundation

struct Reminder: Codable, Hashable {
    let reminderId: Int?
    let daysCount: Int
}

struct ReminderRequest: Codable {
    let userId: Int
    let daysCount: Int
}
