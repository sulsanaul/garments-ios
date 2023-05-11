//
//  NewGarmentView.swift
//  Garments
//
//  Created by Sul S. on 5/11/23.
//

import SwiftUI
import CoreData

struct NewGarmentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  @Environment(\.dismiss) private var dismiss 
  @State private var name: String = ""
  var onSave: (String) -> Void = { _ in }
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Garment name", text: $name)
      }
      .navigationBarTitle("Add", displayMode: .inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            dismiss()
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Save") {
            onSave(name)
            dismiss()
          }
        }
      }
    }
  }
}
