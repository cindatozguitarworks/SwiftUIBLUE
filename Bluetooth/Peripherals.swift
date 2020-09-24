//
//  Peripherals.swift
//  SwiftUIBLUE
//
//  Created by Cynthia Anderson on 9/9/20.
//

import Foundation
import CoreBluetooth


//class BoardPeripheral: NSObject {
   
    // Identifiers for the board
   //LED
   
public let tiSimpleLinkLEDServiceUUID = CBUUID.init( string: "f0001110-0451-4000-b000-000000000000")
public let tiSimpleLinkLED0UUID = CBUUID.init( string: "f0001111-0451-4000-b000-000000000000")
public let tiSimpleLinkLED1UUID = CBUUID.init( string: "f0001112-0451-4000-b000-000000000000")
   //buttton
public let tiSimpleLinkBUTServiceUUID = CBUUID.init( string: "f0001120-0451-4000-b000-000000000000")
public let tiSimpleLinkBUT0UUID = CBUUID.init( string: "f0001121-0451-4000-b000-000000000000")
public let tiSimpleLinkBUT1UUID = CBUUID.init( string: "f0001122-0451-4000-b000-000000000000")
public let tiSimpleLinkDATAStringUUID = CBUUID.init( string: "f0001131-0451-4000-b000-000000000000")
public let tiSimpleLinkDATAStreamUUID = CBUUID.init( string: "f0001132-0451-4000-b000-000000000000")
   
//}


struct Peripheral: Identifiable {
   let id : Int
   let name : String
   let rssi : Int
   
}



