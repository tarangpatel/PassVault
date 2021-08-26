//
//  AddItemView.swift
//  PassVault
//
//  Created by Tarang Patel on 2021-08-24.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var title: String = ""
    @State private var itemDescription: String = ""
    @State private var tags: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var secured: Bool = true
    @State private var hasQuestions: Bool = false
    
    @State private var question1: String = ""
    @State private var answer1: String = ""
    
    @State private var question2: String = ""
    @State private var answer2: String = ""
    
    @State private var question3: String = ""
    @State private var answer3: String = ""
    
    private var item: Item?
    
    init(with item: Item? = nil) {
        self.item = item
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.title)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                TextField("Description", text: $itemDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                TextField("Tags", text: $tags)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
                
                TextField("Username", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                HStack {
                    if secured {
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        TextField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        self.secured.toggle()
                    }, label: {
                        if secured {
                            Image(systemName: "eye.slash")
                        } else {
                            Image(systemName: "eye")
                        }
                    })
                    .padding([.trailing, .leading], 20)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
                
                if hasQuestions {
                    VStack {
                        TextField("Question 1", text: $question1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        TextField("Answer 1", text: $answer1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        TextField("Question 2", text: $question2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        TextField("Answer 2", text: $answer2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        TextField("Question 3", text: $question3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                        TextField("Answer 3", text: $answer3)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    }
                }
                
                Button(action: {
                    self.hasQuestions.toggle()
                }) {
                    if hasQuestions {
                        Label("Remove Secret Questions", systemImage: "minus.circle")
                    } else {
                        Label("Add Secret Questions", systemImage: "plus.circle")
                    }
                }
                .padding(.all, 20)
                
                Button(action: addItem) {
                    Label("Save", systemImage: "square.and.arrow.down")
                }
                .padding(.all, 40)
            }
        }
        .onAppear(perform: {
            if let item = self.item {
                self.title = item.title ?? ""
                self.itemDescription = item.itemDesc ?? ""
                self.userName = item.username ?? ""
                self.password = item.password ?? ""
                self.tags = item.tags ?? ""
            }
        })
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = self.title
            newItem.itemDesc = self.itemDescription
            newItem.tags = self.tags
            newItem.username = userName
            newItem.password = password
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddItemView()
                .padding()
            AddItemView()
        }
    }
}
