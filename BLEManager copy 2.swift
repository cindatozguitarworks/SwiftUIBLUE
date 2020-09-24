//
//  BLEManager.swift
//  SwiftUIBLUE
//
//  Created by Cynthia Anderson on 9/9/20.
//

import Foundation
import CoreBluetooth



class BLEManager: NSObject, ObservableObject, CBPeripheralDelegate, CBCentralManagerDelegate  {
   
   var myCentral: CBCentralManager!
   private var myPeripheral: CBPeripheral!
   
   
   @Published var peripherals = [Peripheral]()
   
   
   @Published var isSwitchedOn = false
   
 //MARK: init
   override init() {
      super.init()
      
      myCentral = CBCentralManager(delegate: self, queue: nil)
      myCentral.delegate = self
      
   }//init
   
   //MARK: Did Update State
   func centralManagerDidUpdateState(_ central: CBCentralManager) {
      if central.state == .poweredOn {
         isSwitchedOn = true
         myCentral.scanForPeripherals(withServices: [tiSimpleLinkLEDServiceUUID])
      }else{
         isSwitchedOn = false
      }
   }//Update State
   
   //MARK: didDiscover
   func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
      
      var peripheralName: String!
      
      if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
         peripheralName = name
      } else {
         peripheralName = "Unknown"
      }
   
      let newPeripheral = Peripheral(id: peripherals.count, name: peripheralName, rssi: RSSI.intValue)
      print(newPeripheral)
      peripherals.append(newPeripheral)
      
     
      myPeripheral = peripheral
      myPeripheral.delegate = self
      
    myCentral.stopScan()
    myCentral.connect(myPeripheral)
 
   }//didDiscover
   
   //MARK: did Connect
   func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
     print("Connected!")
   //  projectZeroPeripheral.discoverServices(nil) **************
      myPeripheral.discoverServices([tiSimpleLinkLEDServiceUUID,tiSimpleLinkBUTServiceUUID])
   }//did connect
   
   //MARK: Did discover Services
   func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
     
     guard let services = peripheral.services else { return }

     for service in services {
       print(service)
       myPeripheral.discoverCharacteristics(nil, for: service)
     }
   }//discover services
   
   //MARK: Did discover characteristics
   func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                   error: Error?) {
     guard let characteristics = service.characteristics else { return }

     for characteristic in characteristics {
       print(characteristic)
     }
   }//discover characteristics
   
   //MARK: start,stop scan
   func startScanning() {
      print("startScanning")
  //    myCentral.scanForPeripherals(withServices: nil, options: nil)
      
      myCentral.scanForPeripherals(withServices: [tiSimpleLinkLEDServiceUUID])
      
   }//start scan
   
   func stopScanning() {
      print("stop scanning")
      myCentral.stopScan()
   }//stop scanning
   
 
} //BLEManagerClass
 



