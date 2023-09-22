import Combine

public extension Sequence where Element: Publisher {
    func combineLatestMany() -> AnyPublisher<[Element.Output], Element.Failure> {
        let emptyPublisher = Just<[Element.Output]>([])
            .setFailureType(to: Element.Failure.self)
            .eraseToAnyPublisher()
        
        return reduce(emptyPublisher) { combined, publisher in
            return combined
                .combineLatest(publisher)
                .map { combinedValues, newValue in
                    combinedValues + [newValue]
                }
                .eraseToAnyPublisher()
        }
    }
}
