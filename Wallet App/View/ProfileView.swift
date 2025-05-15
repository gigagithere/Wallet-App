//
//  ProfileView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 14/05/2025.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var profiles: [UserProfile]
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var defaultCardColor: Color = .blue
    @State private var address: String = ""
    @State private var theme: String = ""
    @State private var birthdate: Date = Date()
    
    @State private var showValidationErrors = false

    var isEmailValid: Bool {
        email.isEmpty || NSPredicate(format:"SELF MATCHES %@", #"^\S+@\S+\.\S+$"#).evaluate(with: email)
    }

    var isPhoneNumberValid: Bool {
        phoneNumber.isEmpty || NSPredicate(format:"SELF MATCHES %@", #"^\+?[0-9]{6,15}$"#).evaluate(with: phoneNumber)
    }

    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Info")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                    if showValidationErrors && !isEmailValid {
                            Text("Invalid email address").foregroundColor(.red)
                        }
                }
                
                Section(header: Text("Personal Details")) {
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    if showValidationErrors && !isPhoneNumberValid {
                            Text("Invalid phone number").foregroundColor(.red)
                        }
                    TextField("Address", text: $address)
                    
                    DatePicker(
                        "Birthdate",
                        selection: $birthdate,
                        in: ...Calendar.current.date(byAdding: .year, value: -13, to: Date())!,
                        displayedComponents: .date)
                }
                
                Section(header: Text("Preferences")) {
                    ColorPicker("Default Card Color", selection: $defaultCardColor)
                    Picker("Theme", selection: $theme) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.palette)
                }
                
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        showValidationErrors = true
                        if isEmailValid && isPhoneNumberValid {
                            saveProfile()
                            showValidationErrors = false
                        }
                    }
                }
            }
            .onAppear(perform: loadProfile)
        }
    }
    
    private func loadProfile() {
        if let profile = profiles.first {
            fullName = profile.fullName
            email = profile.email ?? ""
            phoneNumber = profile.phoneNumber ?? ""
            address = profile.address ?? ""
            theme = profile.theme ?? ""
            birthdate = profile.birthdate ?? Date()
           
        }
    }
    
    private func saveProfile() {
        if let profile = profiles.first {
            profile.fullName = fullName
            profile.email = email
            profile.phoneNumber = phoneNumber
            profile.address = address
            profile.theme = theme
            profile.birthdate = birthdate
            profile.defaultCardColorHex = defaultCardColor.toHex() ?? "#0000FF"
        } else {
            let newProfile = UserProfile(
                fullName: fullName,
                email: email,
                phoneNumber: phoneNumber,
                birthdate: birthdate,
                defaultCardColorHex: defaultCardColor.toHex() ?? "#0000FF",
                address: address,
                theme: theme
            )
            modelContext.insert(newProfile)
        }
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: UserProfile.self)
}
