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
    @Binding var fileBookmark: Data?
    @Binding var documentDate: Date
    @Binding var selectedSourceCompany: String
    @Binding var selectedTargetCompany: String
    @Binding var currentStep: Int

    @State private var newFileName = ""
    @State private var renameMessage = ""
    @State private var didSucceed: Bool? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("5. Summary & Rename")
                .font(.title)
                .fontWeight(.semibold)

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

            if !renameMessage.isEmpty {
                Text(renameMessage)
                    .foregroundColor(didSucceed == true ? .green : .red)
            }

            HStack {
                Button(action: {
                    currentStep = 4
                }) {
                    Text("← Back")
                }
                .disabled(didSucceed == true) // Disable if rename succeeded

                Spacer()

                Button(action: renameFile) {
                    Text("Rename File")
                }
                .tint(.accentColor)
                .disabled(didSucceed == true) // Disable after success
            }
        }
        .onAppear(perform: generateNewFileName)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    private func generateNewFileName() {
        guard let selectedFile = selectedFile else { return }
        let dateString = dateFormatter.string(from: documentDate)
        let fileExtension = selectedFile.pathExtension
        
        newFileName = "\(dateString)_\(selectedSourceCompany)_\(selectedTargetCompany).\(fileExtension)"
    }

    private func renameFile() {
        guard let bookmark = fileBookmark else {
            renameMessage = "Error: Bookmark is not available."
            didSucceed = false
            return
        }

        do {
            var isStale = false
            let originalURL = try URL(resolvingBookmarkData: bookmark, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
            
            guard originalURL.startAccessingSecurityScopedResource() else {
                renameMessage = "Error: Could not gain permission to access file."
                didSucceed = false
                return
            }
            
            let directory = originalURL.deletingLastPathComponent()
            let destinationURL = directory.appendingPathComponent(newFileName)
            try FileManager.default.moveItem(at: originalURL, to: destinationURL)
            
            originalURL.stopAccessingSecurityScopedResource()
            
            renameMessage = "File successfully renamed!"
            didSucceed = true
            
        } catch {
            renameMessage = "Error: \(error.localizedDescription)"
            didSucceed = false
        }
    }
}
