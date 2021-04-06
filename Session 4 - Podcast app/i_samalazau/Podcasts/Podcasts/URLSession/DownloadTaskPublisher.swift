//
//  DownloadTaskPublisher.swift
//  Podcasts
//
//  Created by Ivan Samalazau on 16/03/2021.
//

import Foundation
import Combine

enum DownloadOutput {
    case completed(fileURL: URL)
    case downloading(DownloadProgress)
}

struct DownloadProgress: Equatable {
    let received: Int64
    let expected: Int64

    static var zero: Self {
        .init(received: 0, expected: 0)
    }
}

fileprivate class CancellableStore {

    static let shared = CancellableStore()
    var cancellables = Set<AnyCancellable>()
}

extension URLSession {

    func downloadTaskPublisher(for url: URL) -> AnyPublisher<DownloadOutput, URLError> {
        downloadTaskPublisher(for: .init(url: url))
    }

    func downloadTaskPublisher(for request: URLRequest) -> AnyPublisher<DownloadOutput, URLError> {

        let subject = PassthroughSubject<DownloadOutput, URLError>()

        let task = downloadTask(with: request) { (tempURL, response, error) in

            if let error = error as? URLError {
                subject.send(completion: .failure(error))
                return
            }

            guard let response = response else {
                subject.send(completion: .failure(URLError(.badServerResponse)))
                return
            }

            guard let url = tempURL else {
                subject.send(completion: .failure(URLError(.fileDoesNotExist)))
                return
            }

            do {
                let cacheDir = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
                let fileUrl = cacheDir.appendingPathComponent(response.suggestedFilename ?? UUID().uuidString)
                try FileManager.default.moveItem(atPath: url.path, toPath: fileUrl.path)
                subject.send(.completed(fileURL: fileUrl))
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(URLError(.cannotCreateFile)))
                return
            }
        }

        task.taskDescription = request.url?.absoluteString

        let receivedPublisher = task.publisher(for: \.countOfBytesReceived)
            .debounce(for: .seconds(0.01), scheduler: RunLoop.current)

        let expectedPublisher = task.publisher(for: \.countOfBytesExpectedToReceive, options: [.initial, .new])

        Publishers.CombineLatest(receivedPublisher, expectedPublisher)
            .sink {
                let (received, expected) = $0
                let output = DownloadOutput.downloading(DownloadProgress(received: received, expected: expected))
                subject.send(output)
                print("\(received) of \(expected)")
            }
            .store(in: &CancellableStore.shared.cancellables)

        task.resume()
        return subject.eraseToAnyPublisher()
    }
}
