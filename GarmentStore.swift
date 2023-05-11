//
//  GarmentStore.swift
//  Garments
//
//  Created by Sul S. on 5/11/23.
//

import CoreData
import SwiftUI

class GarmentStore: ObservableObject {
  @Published var garments: [Garment] = []
  
  private let context: NSManagedObjectContext
  
  init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
      self.context = context
      fetchGarments()
  }
  
  func fetchGarments() {
    let request = NSFetchRequest<Garment>(entityName: "Garment")
    request.sortDescriptors = [NSSortDescriptor(keyPath: \Garment.creationDate, ascending: true)]
    
    do {
      garments = try context.fetch(request)
    } catch {
      print("Error fetching garments: \(error)")
    }
  }
  
  func addGarment(name: String) {
    let newGarment = Garment(context: PersistenceController.shared.container.viewContext)
    newGarment.creationDate = Date()
    newGarment.name = name
    
    do {
      try context.save()
      fetchGarments()
    } catch {
      print("Error saving garment: \(error)")
    }
  }
}
