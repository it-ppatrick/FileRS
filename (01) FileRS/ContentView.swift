//
//  ContentView.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct ContentView: View {
    // --- Add this new state variable for the date ---
    @State private var documentDate = Date() // Defaults to today's date
    
    // --- Add this new state variable for the source company ---
    @State private var selectedSourceCompany: String = ""


    @State private var currentStep = 1
    @State private var selectedFile: URL?

    var body: some View {
        VStack(spacing: 20) {
            Text("File Renamer")
                .font(.largeTitle)
                .fontWeight(.bold)

            // --- Update this logic to include Step 3 ---
            if currentStep == 1 {
                Step1_UploadView(
                    selectedFile: $selectedFile,
                    currentStep: $currentStep
                )
            } else if currentStep == 2 {
                Step2_DateView(
                    documentDate: $documentDate,
                    currentStep: $currentStep
                )
            } else if currentStep == 3 {
                Step3_SourceCompanyView(
                    selectedSourceCompany: $selectedSourceCompany,
                    currentStep: $currentStep
                )
            }
            else {
                // Placeholder for the next steps
                Text("You are on step \(currentStep)")
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 450)
    }
}

#Preview {
    ContentView()
        .environmentObject(CompanyStore()) // Also add it to the preview
}
