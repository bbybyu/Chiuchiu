import SwiftUI

struct PetView: View {
    @State private var isBreathing = false
    @State private var isBlinking = false
    @State private var blinkTimer: Timer?
    @State private var blinkEndTimer: Timer?

    var body: some View {
        Image(isBlinking ? "ChiuChiuBlink" : "ChiuChiuIdleFront")
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
                scheduleNextBlink()
            }
            .onDisappear {
                stopBlinkTimers()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
    }

    private func scheduleNextBlink() {
        blinkTimer?.invalidate()
        let timer = Timer(
            timeInterval: Double.random(in: 5...10),
            repeats: false
        ) { _ in
            MainActor.assumeIsolated {
                isBlinking = true
                scheduleBlinkEnd()
            }
        }
        blinkTimer = timer
        RunLoop.main.add(timer, forMode: .common)
    }

    private func scheduleBlinkEnd() {
        blinkEndTimer?.invalidate()
        let timer = Timer(
            timeInterval: Double.random(in: 0.15...0.25),
            repeats: false
        ) { _ in
            MainActor.assumeIsolated {
                isBlinking = false
                scheduleNextBlink()
            }
        }
        blinkEndTimer = timer
        RunLoop.main.add(timer, forMode: .common)
    }

    private func stopBlinkTimers() {
        blinkTimer?.invalidate()
        blinkEndTimer?.invalidate()
        blinkTimer = nil
        blinkEndTimer = nil
        isBlinking = false
    }
}
