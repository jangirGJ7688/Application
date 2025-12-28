//
//  NetworkMonitor.swift
//  Application
//
//  Created by Ganpat Jangir on 27/12/25.
//

import Foundation
import Network

final class NetworkMonitor {

    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isConnected: Bool = false

    var onStatusChange: ((Bool) -> Void)?

    private init() {}

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            let connected = path.status == .satisfied
            self?.isConnected = connected
            DispatchQueue.main.async {
                self?.onStatusChange?(connected)
            }
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
