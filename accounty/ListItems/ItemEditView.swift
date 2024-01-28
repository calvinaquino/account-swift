//
//  ItemEditView.swift
//  accounty
//
//  Created by Calvin Gonçalves de Aquino on 2024-01-08.
//

import SwiftUI
import SwiftData

struct ItemEditView: View {
    @Bindable var item: Item
    let list: ShoppingList
    @Query private var categories: [Category]
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.minimum = 0.00
        return formatter
    }
    
    init(item: Item, list: ShoppingList) {
        self.item = item
        self.list = list
        let id = list.persistentModelID
        self._categories = Query(filter: #Predicate<Category> { $0.list.persistentModelID == id })
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $item.name)
            #warning("Fix textField with currency formatter. Maybe just make it a String? or use number formatter instead of currency")
            // Something is shitty here
//            TextField("Cost", value: $item.cost, formatter: currencyFormatter)
//                .keyboardType(.decimalPad)
            Toggle("Stocked", isOn: $item.isStocked)
            Toggle("Active", isOn: $item.isActive)
            Toggle("One time purchase", isOn: $item.once)
            //
            Section("Category") {
                Picker("Category", selection: $item.category) {
                    Text("None").tag(nil as Category?)
                    ForEach(categories) { category in
                        Text(category.name).tag(category as Category?)
                    }
                }
            }
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let moc = DataProvider.previewContainer()
    let item = Item.example()
    moc.mainContext.insert(ShoppingList.defaultExample)
    moc.mainContext.insert(item)
    return NavigationView {
        ItemEditView(item: item, list: .defaultExample)
            .modelContainer(moc)
    }
}
