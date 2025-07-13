//
//  01_Upload-View.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct Step2_DateView: View {
    // Bindings to share the date and current step with ContentView
    @Binding var documentDate: Date
    @Binding var currentStep: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("2. Select Document Date")
                .font(.title)
                .fontWeight(.semibold)

            // A graphical calendar style DatePicker.
            // Its selection is directly bound to our state variable.
            DatePicker(
                "Document Date",
                selection: $documentDate,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .labelsHidden() // We hide the default label to use our own title.

            // Navigation buttons
            HStack {
                Button(action: {
                    currentStep = 1 // Go back to Step 1
                }) {
                    Text("← Back")
                }

                Spacer()

                Button(action: {
                    currentStep = 3 // Go forward to Step 3
                }) {
                    Text("Next →")
                }
            }
        }
    }
}
