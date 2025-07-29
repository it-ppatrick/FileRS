//
//  04_Target-Company-View.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct Step4_TargetCompanyView: View {
    @EnvironmentObject var companyStore: CompanyStore
    @Binding var selectedTargetCompany: String
    @Binding var currentStep: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("4. Select Target Company")
                .font(.title)
                .fontWeight(.semibold)

            // A Picker to select the target company
            Picker("Target Company", selection: $selectedTargetCompany) {
                ForEach(companyStore.targetCompanies) { company in
                    Text(company.name).tag(company.name)
                }
            }
            .pickerStyle(MenuPickerStyle()) // A dropdown-style picker

            // Navigation buttons
            HStack {
                Button(action: {
                    currentStep = 3 // Go back to Step 3
                }) {
                    Text("← Back")
                }

                Spacer()

                Button(action: {
                    currentStep = 5 // Go forward to Step 5
                }) {
                    Text("Next →")
                }
            }
        }
        .onAppear {
            // Set a default value if none is selected
            if selectedTargetCompany.isEmpty {
                selectedTargetCompany = companyStore.targetCompanies.first?.name ?? ""
            }
        }
    }
}
