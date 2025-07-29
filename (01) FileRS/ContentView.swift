//
//  ContentView.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct ContentView: View {
    // Access the company store from the environment
    @EnvironmentObject var companyStore: CompanyStore
    
    // State variables for all steps
    @State private var documentDate = Date()
    @State private var selectedSourceCompany: String = ""
    @State private var selectedTargetCompany: String = ""
    @State private var currentStep = 1
    @State private var selectedFile: URL?
    @State private var fileBookmark: Data?

    var body: some View {
        VStack(spacing: 20) {
            Text("File Renamer")
                .font(.largeTitle)
                .fontWeight(.bold)

            // This is the logic that was accidentally removed
            if currentStep == 1 {
                Step1_UploadView(
                    selectedFile: $selectedFile,
                    fileBookmark: $fileBookmark,
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
                    fileBookmark: $fileBookmark,
                    documentDate: $documentDate,
                    selectedSourceCompany: $selectedSourceCompany,
                    selectedTargetCompany: $selectedTargetCompany,
                    currentStep: $currentStep
                )
            }
        }
        .padding()
        .frame(minWidth: 500, minHeight: 450)
        .onAppear(perform: initializeSelections) // Initializes picker selections
    }
    
    // This function fixes the "Picker selection is invalid" warning
    private func initializeSelections() {
        if selectedSourceCompany.isEmpty {
            selectedSourceCompany = companyStore.sourceCompanies.first?.name ?? ""
        }
        if selectedTargetCompany.isEmpty {
            selectedTargetCompany = companyStore.targetCompanies.first?.name ?? ""
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(CompanyStore())
}
