// Automatically generated by the Fast Binary Encoding compiler, do not modify!
// https://github.com/chronoxor/FastBinaryEncoding
// Source: Fbe
// Version: 1.3.0.0

import Foundation

// Fast Binary Encoding base sender
public protocol SenderProtocol: class {

    // Get the bytes buffer
    var buffer: Buffer { get set }

    // Enable/Disable logging
    var logging: Bool { get set }

    // Get the final protocol flag
    var final: Bool { get set }


    // Send message handler
    func onSend(buffer: Data, offset: Int, size: Int) throws -> Int
}

public extension SenderProtocol {

    func build(with final: Bool) {
        self.final = final
    }

    func build(with buffer: Buffer, final: Bool) {
        self.buffer = buffer
        self.final = final
    }

    // Reset the sender buffer
    func reset() { buffer.reset() }

    // Send serialized buffer.
    // Direct call of the method requires knowledge about internals of FBE models serialization.
    // Use it with care!
    func sendSerialized(serialized: Int) throws -> Int {
        if (serialized <= 0) {
            assertionFailure("Invalid size of the serialized buffer!")
            return 0
        }

        // Shift the send buffer
        buffer.shift(offset: serialized)

        // Send the value
        let sent = try onSend(buffer: buffer.data, offset: 0, size: buffer.size)
        try _ = buffer.remove(offset: 0, size: sent)
        return sent
    }
}