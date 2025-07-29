//
//  03_Source-Company-View.swift
//  
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct Step3_SourceCompanyView: View {
    @EnvironmentObject var companyStore: CompanyStore
    @Binding var selectedSourceCompany: String
    @Binding var currentStep: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("3. Select Source Company")
                .font(.title)
                .fontWeight(.semibold)

            // A Picker to select the source company
            Picker("Source Company", selection: $selectedSourceCompany) {
                ForEach(companyStore.sourceCompanies) { company in
                    Text(company.name).tag(company.name)
                }
            }
            .pickerStyle(MenuPickerStyle()) // A dropdown-style picker

            // Navigation buttons
            HStack {
                Button(action: {
                    currentStep = 2 // Go back to Step 2
                }) {
                    Text("← Back")
                }

                Spacer()

                Button(action: {
                    currentStep = 4 // Go forward to Step 4
                }) {
                    Text("Next →")
                }
            }
        }
        .onAppear {
            // Set a default value if none is selected
            if selectedSourceCompany.isEmpty {
                selectedSourceCompany = companyStore.sourceCompanies.first?.name ?? ""
            }
        }
    }
}
