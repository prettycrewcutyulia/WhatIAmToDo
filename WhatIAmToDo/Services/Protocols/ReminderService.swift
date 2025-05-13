protocol ReminderService {
    func getReminders(completion: @escaping (Result<[Reminder], Error>) -> Void)
    func addReminder(_ reminder: Reminder, completion: @escaping (Result<Int, Error>) -> Void)
    func deleteReminder(by id: Int, completion: @escaping (Result<Void, Error>) -> Void)
}
