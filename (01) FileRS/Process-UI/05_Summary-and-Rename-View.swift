//
//  05_Summary-and-Rename-View.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

struct Step5_SummaryView: View {
    // All the data from previous steps
    @Binding var selectedFile: URL?
    @Binding var documentDate: Date
    @Binding var selectedSourceCompany: String
    @Binding var selectedTargetCompany: String
    @Binding var currentStep: Int

    // State for the new filename
    @State private var newFileName = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("5. Summary & Rename")
                .font(.title)
                .fontWeight(.semibold)

            // Display a summary of the selected data
            VStack(alignment: .leading, spacing: 10) {
                Text("Original File: \(selectedFile?.lastPathComponent ?? "N/A")")
                Text("Document Date: \(documentDate, formatter: dateFormatter)")
                Text("Source Company: \(selectedSourceCompany)")
                Text("Target Company: \(selectedTargetCompany)")
                Divider()
                Text("New Filename: \(newFileName)")
                    .fontWeight(.bold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(10)


            // Navigation and action buttons
            HStack {
                Button(action: {
                    currentStep = 4 // Go back to Step 4
                }) {
                    Text("← Back")
                }

                Spacer()

                Button(action: renameFile) {
                    Text("Rename File")
                }
                .tint(.accentColor)
            }
        }
        .onAppear(perform: generateNewFileName)
    }

    // Formats the date for the filename
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    // Constructs the new filename
    private func generateNewFileName() {
        guard let selectedFile = selectedFile else { return }
        let dateString = dateFormatter.string(from: documentDate)
        let fileExtension = selectedFile.pathExtension
        
        // Format: YYYY-MM-DD_Source_Target.extension
        newFileName = "\(dateString)_\(selectedSourceCompany)_\(selectedTargetCompany).\(fileExtension)"
    }

    // Performs the file renaming
    private func renameFile() {
        guard let originalURL = selectedFile else { return }

        // Create the destination URL
        let directory = originalURL.deletingLastPathComponent()
        let destinationURL = directory.appendingPathComponent(newFileName)

        do {
            // Attempt to move (rename) the file
            try FileManager.default.moveItem(at: originalURL, to: destinationURL)
            print("File successfully renamed to \(newFileName)")
            
            // Optionally, reset the app to the beginning
            // currentStep = 1
            // selectedFile = nil

        } catch {
            print("Error renaming file: \(error.localizedDescription)")
            // Here you could show an alert to the user
        }
    }
}
