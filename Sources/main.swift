import Combine
import Foundation

func run() {
    var subscriptions: Set<AnyCancellable> = Set()
    let tick: some Publisher<Date, Never> = Timer
        .publish(every: 1, on: .main, in: .default)
        .autoconnect()
    tick.print()
        .sink { _ in } // Do nothing, just consuming for the print() output
        .store(in: &subscriptions)
    
    RunLoop.main.run()
    // Works as expected when there's a reference to subscriptions at the end of the block
//    let subscriptions2 = subscriptions
}

run()
