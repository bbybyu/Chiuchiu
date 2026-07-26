import SwiftUI

struct PetView: View {
    @State private var isBreathing = false

    var body: some View {
        Image("ChiuChiuIdleFront")
            .resizable()
            .scaledToFit()
            .frame(width: 220, height: 220)
            .scaleEffect(isBreathing ? 1.008 : 1, anchor: .bottom)
            .offset(y: isBreathing ? -1.5 : 0)
            .animation(
                .easeInOut(duration: 2.4).repeatForever(autoreverses: true),
                value: isBreathing
            )
            .onAppear {
                isBreathing = true
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
    }
}
