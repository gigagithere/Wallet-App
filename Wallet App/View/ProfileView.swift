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
    @State private var birthdate: Date = Date()
    
    @AppStorage("appTheme") private var appTheme: String = "system"
    
    var theme: AppThemeStyle {
        AppTheme(rawValue: appTheme)?.style ?? .system
    }
    
    @State private var showResetConfirmation = false
    
    @State private var showValidationErrors = false
    
   
    

    var isEmailValid: Bool {
        email.isEmpty || NSPredicate(format: "SELF MATCHES %@", #"^\S+@\S+\.\S+$"#).evaluate(with: email)
    }

    var isPhoneNumberValid: Bool {
        phoneNumber.isEmpty || NSPredicate(format: "SELF MATCHES %@", #"^\+?[0-9]{6,15}$"#).evaluate(with: phoneNumber)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundGradient.ignoresSafeArea()
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
                        
                        Picker("Color Theme", selection: $appTheme) {
                            ForEach(AppTheme.allCases) { theme in
                                Text(theme.rawValue.capitalized).tag(theme.rawValue)
                            }
                        }
                        
                        Button(role: .destructive) {
                            showResetConfirmation = true
                        } label: {
                            Text("Reset all data")
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
                .confirmationDialog("Are you sure you want to reset all data?", isPresented: $showResetConfirmation) {
                    Button("Reset", role: .destructive) {
                        resetAllData()
                    }
                    Button("Cancel", role: .cancel) {}
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
            .foregroundColor(theme.textColor)
            .accentColor(theme.accentColor)
        }
    }

    private func loadProfile() {
        if let profile = profiles.first {
            fullName = profile.fullName
            email = profile.email ?? ""
            phoneNumber = profile.phoneNumber ?? ""
            address = profile.address ?? ""
            birthdate = profile.birthdate ?? Date()
            if let hex = profile.defaultCardColorHex, let color = Color(hex: hex) {
                defaultCardColor = color
            } else {
                defaultCardColor = .blue
            }
        }
    }

    private func saveProfile() {
        if let profile = profiles.first {
            profile.fullName = fullName
            profile.email = email
            profile.phoneNumber = phoneNumber
            profile.address = address
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
                theme: nil
            )
            modelContext.insert(newProfile)
        }
    }

    private func resetAllData() {
        for profile in profiles {
            modelContext.delete(profile)
        }
        let descriptor = FetchDescriptor<Card>()
        if let cards = try? modelContext.fetch(descriptor) {
            for card in cards {
                modelContext.delete(card)
            }
        }
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: [UserProfile.self, Card.self])
}
