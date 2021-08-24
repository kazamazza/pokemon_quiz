import Foundation
import UIKit
import CoreData

extension Character {
    static func fetch(predicate: NSPredicate?, moc: NSManagedObjectContext) -> [Character]? {
        let request = NSFetchRequest<Character>(entityName: "Character")
        if predicate != nil {request.predicate = predicate}
        do {
            return try moc.fetch(request)
        } catch {
            return nil
        }
    }
}

extension NSPersistentContainer {
  func saveContextIfNeeded() {
    if viewContext.hasChanges {
      do {
        try viewContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
