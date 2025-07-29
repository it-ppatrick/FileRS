//
//  ContentView.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct ContentView: View {
    // --- State variables for all steps ---
    @State private var documentDate = Date()
    @State private var selectedSourceCompany: String = ""
    @State private var selectedTargetCompany: String = ""
    @State private var currentStep = 1
    @State private var selectedFile: URL?

    var body: some View {
        VStack(spacing: 20) {
            Text("File Renamer")
                .font(.largeTitle)
                .fontWeight(.bold)

            // --- Update this logic to include Step 5 ---
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
            } else if currentStep == 4 {
                Step4_TargetCompanyView(
                    selectedTargetCompany: $selectedTargetCompany,
                    currentStep: $currentStep
                )
            } else if currentStep == 5 {
                Step5_SummaryView(
                    selectedFile: $selectedFile,
                    documentDate: $documentDate,
                    selectedSourceCompany: $selectedSourceCompany,
                    selectedTargetCompany: $selectedTargetCompany,
                    currentStep: $currentStep
                )
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 450)
    }
}

#Preview {
    ContentView()
        .environmentObject(CompanyStore())
}
