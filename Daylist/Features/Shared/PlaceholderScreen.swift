import SwiftUI

/// Stand-in for screens that a later stage or milestone builds. Removed once M3 is done.
struct PlaceholderScreen: View {
    let title: String
    var note: String = "Placeholder, built in a later stage."
    var actions: [PlaceholderAction] = []

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text(title)
                .font(.largeTitle.bold())
            Text(note)
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
            ForEach(actions) { action in
                Button(action: action.perform) {
                    Text(action.title)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PlaceholderAction: Identifiable {
    let id = UUID()
    let title: String
    let perform: () -> Void

    init(_ title: String, perform: @escaping () -> Void) {
        self.title = title
        self.perform = perform
    }
}
