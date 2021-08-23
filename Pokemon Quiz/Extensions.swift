import Foundation
import UIKit
import CoreData

extension Character {
    static func fetch(predicate: NSPredicate, moc: NSManagedObjectContext) -> [Character]? {
        let request = NSFetchRequest<Character>(entityName: "Character")
        request.predicate = predicate
        do {
            return try moc.fetch(request)
        } catch {
            return nil
        }
    }
}
