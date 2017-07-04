//
//  VSController.swift
//  vs-metal
//
//  Created by SATOSHI NAKAJIMA on 6/23/17.
//  Copyright © 2017 SATOSHI NAKAJIMA. All rights reserved.
//
import Foundation
import MetalKit

struct VSController : VSNode {
    private var encoder:((MTLCommandBuffer, VSContext) throws -> (Void))

    private static func fork(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        let texture = try context.pop()
        context.push(texture:texture)
        context.push(texture:texture)
    }

    private static func swap(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        let texture1 = try context.pop()
        let texture2 = try context.pop()
        context.push(texture:texture1)
        context.push(texture:texture2)
    }

    private static func discard(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        let _ = try context.pop()
    }

    private static func shift(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        context.shift()
    }

    private static func previous(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        let texture = context.prev()
        context.push(texture: texture)
    }

    static func makeNode(name:String) -> VSNode? {
        switch(name) {
        case "fork": return VSController(encoder: fork)
        case "swap": return VSController(encoder: swap)
        case "discard": return VSController(encoder: discard)
        case "shift": return VSController(encoder: shift)
        case "previous": return VSController(encoder: previous)
        default: return nil
        }
    }

    func encode(commandBuffer:MTLCommandBuffer, context:VSContext) throws {
        try encoder(commandBuffer,context)
    }
}
