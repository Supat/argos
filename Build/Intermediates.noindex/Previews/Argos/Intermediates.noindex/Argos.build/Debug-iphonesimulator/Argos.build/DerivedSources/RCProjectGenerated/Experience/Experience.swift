//
// Experience.swift
// GENERATED CONTENT. DO NOT EDIT.
//

import Foundation
import RealityKit
import simd
import Combine

public enum Experience {

    public enum LoadRealityFileError: Error {
        case fileNotFound(String)
    }

    private static var streams = [Combine.AnyCancellable]()

    public static func loadBox() throws -> Experience.Box {
        guard let realityFileURL = Foundation.Bundle(for: Experience.Box.self).url(forResource: "Experience", withExtension: "reality") else {
            throw Experience.LoadRealityFileError.fileNotFound("Experience.reality")
        }

        let realityFileSceneURL = realityFileURL.appendingPathComponent("Box", isDirectory: false)
        let anchorEntity = try Experience.Box.loadAnchor(contentsOf: realityFileSceneURL)
        return createBox(from: anchorEntity)
    }

    public static func loadBoxAsync(completion: @escaping (Swift.Result<Experience.Box, Swift.Error>) -> Void) {
        guard let realityFileURL = Foundation.Bundle(for: Experience.Box.self).url(forResource: "Experience", withExtension: "reality") else {
            completion(.failure(Experience.LoadRealityFileError.fileNotFound("Experience.reality")))
            return
        }

        var cancellable: Combine.AnyCancellable?
        let realityFileSceneURL = realityFileURL.appendingPathComponent("Box", isDirectory: false)
        let loadRequest = Experience.Box.loadAnchorAsync(contentsOf: realityFileSceneURL)
        cancellable = loadRequest.sink(receiveCompletion: { loadCompletion in
            if case let .failure(error) = loadCompletion {
                completion(.failure(error))
            }
            streams.removeAll { $0 === cancellable }
        }, receiveValue: { entity in
            completion(.success(Experience.createBox(from: entity)))
        })
        cancellable?.store(in: &streams)
    }

    private static func createBox(from anchorEntity: RealityKit.AnchorEntity) -> Experience.Box {
        let box = Experience.Box()
        box.anchoring = anchorEntity.anchoring
        box.addChild(anchorEntity)
        return box
    }

    public class Box: RealityKit.Entity, RealityKit.HasAnchoring {

        public var steelBox: RealityKit.Entity? {
            return self.findEntity(named: "Steel Box")
        }

    }

}
