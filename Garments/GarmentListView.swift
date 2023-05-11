//
//  ContentView.swift
//  Garments
//
//  Created by Sul S. on 5/11/23.
//

import CoreData
import SwiftUI


struct GarmentListView: View {
  @ObservedObject var garmentStore = GarmentStore()
  @State private var newGarmentModalIsPresented = false
  @State private var sortOption: SortOption = .alphabetical
  
  private var garments : [Garment] {
    garmentStore.garments
  }
  private enum SortOption: String, CaseIterable {
    case alphabetical = "Alphabetical"
    case date = "By Date"
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Picker("Sort by", selection: $sortOption) {
          ForEach(SortOption.allCases, id: \.self) { option in
            Text(option.rawValue)
          }
        }.pickerStyle(.segmented)
        List {
          ForEach(garments.sorted(by: { sortGarments(lhs: $0, rhs: $1) })) { garment in
            Text(garment.name ?? "")
          }
        }
        .navigationBarTitle("List", displayMode: .inline)
        .toolbar {
          ToolbarItem {
            Button(action: { self.newGarmentModalIsPresented = true }) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }
        .sheet(isPresented: $newGarmentModalIsPresented) {
          NewGarmentView() {
            garmentStore.addGarment(name: $0)
          }
        }
      }
    }
  }
  
  func sortGarments(lhs: Garment, rhs: Garment) -> Bool {
    switch sortOption {
    case .alphabetical:
      guard let lhsName = lhs.name,
            let rhsName = rhs.name else {
        return false
      }
      return lhsName < rhsName
    case .date:
      guard let lhsDate = lhs.creationDate,
            let rhsDate = rhs.creationDate else {
        return false
      }
      return lhsDate > rhsDate
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GarmentListView().environment(
      \.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
