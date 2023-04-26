/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 5.0) {
                Text("Eita! 🤕")
                    .font(.title)
                    .padding([.top, .bottom])
                Text("Foi um erro da nossa parte...")
                Text(errorWrapper.guidance)
                    .font(.callout)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Entendi") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                     guidance: "Pode ficar tranquilo!")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
