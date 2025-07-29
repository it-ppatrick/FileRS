//
//  01_Upload-View.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct Step1_UploadView: View {
    // These bindings allow this view to share data with the ContentView.
    @Binding var selectedFile: URL?
    @Binding var fileBookmark: Data? // Binding for the secure bookmark
    @Binding var currentStep: Int

    var body: some View {
        VStack(spacing: 20) {
            Text("1. Upload Document")
                .font(.title)
                .fontWeight(.semibold)

            // If no file is selected, show the button.
            if selectedFile == nil {
                // The button's action now calls our private function
                Button(action: selectFile) {
                    Text("Click to select a file")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(10)
                }
                .buttonStyle(.plain) // Use a plain style for custom background.
            } else {
                // If a file IS selected, show its name.
                Text(selectedFile!.lastPathComponent)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
            }

            // The "Next" button.
            Button(action: {
                currentStep = 2 // Advance to the next step
            }) {
                Text("Next →")
            }
            // The button is disabled until a file is chosen.
            .disabled(selectedFile == nil)
        }
    }

    // This function must be inside the Step1_UploadView struct's braces.
    private func selectFile() {
        let panel = NSOpenPanel()
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false

        if panel.runModal() == .OK, let url = panel.urls.first {
            do {
                // Create the secure bookmark data
                let bookmarkData = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
                self.fileBookmark = bookmarkData // Save the bookmark
                self.selectedFile = url          // Save the URL
            } catch {
                print("Error creating bookmark: \(error.localizedDescription)")
                // You could show an alert to the user here
            }
        }
    }
}
