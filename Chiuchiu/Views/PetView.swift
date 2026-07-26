import SwiftUI

private struct TouchAnimationValues {
    var verticalOffset = 0.0
    var horizontalOffset = 0.0
}

struct PetView: View {
    @State private var isBreathing = false
    @State private var isBlinking = false
    @State private var isHappy = false
    @State private var blinkTimer: Timer?
    @State private var blinkEndTimer: Timer?
    @State private var happyTimer: Timer?
    @State private var touchAnimationTrigger = 0

    var body: some View {
        Image(
            (isHappy || isBlinking)
                ? "ChiuChiuBlink"
                : "ChiuChiuIdleFront"
        )
            .resizable()
            .scaledToFit()
            .frame(width: 220, height: 220)
            .scaleEffect(isBreathing ? 1.008 : 1, anchor: .bottom)
            .offset(y: isBreathing ? -1.5 : 0)
            .animation(
                .easeInOut(duration: 2.4).repeatForever(autoreverses: true),
                value: isBreathing
            )
            .keyframeAnimator(
                initialValue: TouchAnimationValues(),
                trigger: touchAnimationTrigger
            ) { content, value in
                content
                    .offset(
                        x: value.horizontalOffset,
                        y: value.verticalOffset
                    )
            } keyframes: { _ in
                KeyframeTrack(\.verticalOffset) {
                    SpringKeyframe(
                        -2.5,
                        duration: 0.24,
                        spring: .smooth
                    )
                    SpringKeyframe(
                        0,
                        duration: 0.46,
                        spring: .smooth
                    )
                }

                KeyframeTrack(\.horizontalOffset) {
                    SpringKeyframe(
                        -0.8,
                        duration: 0.2,
                        spring: .smooth
                    )
                    SpringKeyframe(
                        0.8,
                        duration: 0.24,
                        spring: .smooth
                    )
                    SpringKeyframe(
                        0,
                        duration: 0.26,
                        spring: .smooth
                    )
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                respondToTouch()
            }
            .onAppear {
                isBreathing = true
                scheduleNextBlink()
            }
            .onDisappear {
                stopTimers()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.clear)
    }

    private func respondToTouch() {
        touchAnimationTrigger += 1
        happyTimer?.invalidate()
        isHappy = true

        let timer = Timer(
            timeInterval: 0.8,
            repeats: false
        ) { _ in
            MainActor.assumeIsolated {
                isHappy = false
                happyTimer = nil
            }
        }
        happyTimer = timer
        RunLoop.main.add(timer, forMode: .common)
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

    private func stopTimers() {
        blinkTimer?.invalidate()
        blinkEndTimer?.invalidate()
        happyTimer?.invalidate()
        blinkTimer = nil
        blinkEndTimer = nil
        happyTimer = nil
        isBlinking = false
        isHappy = false
    }
}
