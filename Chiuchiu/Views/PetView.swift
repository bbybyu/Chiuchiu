import SwiftUI

struct PetView: View {
    var body: some View {
        Image("ChiuChiuIdleFront")
            .resizable()
            .scaledToFit()
            .padding(12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
    }
}
