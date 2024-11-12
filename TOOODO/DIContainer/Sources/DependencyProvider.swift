import Swinject

public class DependencyProvider {
    nonisolated(unsafe) public static let shared = DependencyProvider()

    public let container = Container()
}
