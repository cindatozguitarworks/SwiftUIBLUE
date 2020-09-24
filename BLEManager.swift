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
   
   //Characteristics
  private var redCharacteristic:  CBCharacteristic!
  private var greenCharacteristic:  CBCharacteristic!
   
   
   @Published var peripherals = [Peripheral]()
   
   
   @Published var isSwitchedOn = false
   @Published var buttonZeroState = " OFF "
   @Published var buttonZeroisOn: Bool = false
   @Published var buttonOneState = " OFF "
   @Published var buttonOneisOn: Bool = false
   
   @Published var redLEDState = " OFF "
   @Published var greenLEDState = " OFF "
   @Published var redLEDisOn: Bool = false
   @Published var greenLEDisOn: Bool = false
 //  @Published var
   

   
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
    //  if service.uuid == tiSimpleLinkLEDServiceUUID {
       myPeripheral.discoverCharacteristics(
         [
            //myPeripheral.
                 tiSimpleLinkLED0UUID,
             //  myPeripheral.
                 tiSimpleLinkLED1UUID,
             //  myPeripheral.
                 tiSimpleLinkBUT0UUID,
              // myPeripheral.
                 tiSimpleLinkBUT1UUID,
            //  myPeripheral.
                 tiSimpleLinkDATAStringUUID], //myPeripheral.tiSimpleLinkDATAStreamUUID],
              for: service);
          }
    // }
   }//discover services
   
   //MARK: Did discover characteristics
   func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                   error: Error?) {
     guard let characteristics = service.characteristics else { return }

     for characteristic in characteristics {
       print(characteristic)
      
      if characteristic.uuid == tiSimpleLinkLED0UUID {
          print ("LED0 Characteristic found",characteristic)
       
          redCharacteristic = characteristic
         //unmask red slider
        //    redSlider.isEnabled = true
      }else if
         characteristic.uuid == tiSimpleLinkLED1UUID {
         print ("LED1 Characteristic found",characteristic)
      
         greenCharacteristic = characteristic
      //unmask red slider
     //    greenSlider.isEnabled = true
      }
      
      if characteristic.properties.contains(.read) {
         print(" contains .read$$$$$$$$$$$$$")
         peripheral.readValue(for: characteristic)
      }
      if characteristic.properties.contains(.notify) {
         print("(contains .notify&&&&&&&&&&&&&")
         peripheral.setNotifyValue(true, for: characteristic)

      }
     }
   }//discover characteristics
   
   // MARK: - DID UPDATE VALUE PERIPHERAL
   //**Must read the characteristic first, and then are notified when the characteristic is read
 func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic,
                   error: Error?) {
   
     switch characteristic.uuid {
     
     
     
     case  tiSimpleLinkBUT0UUID :
       let buttonOnOff = buttonState(from: characteristic)
           buttonZeroState = buttonOnOff
        print(buttonOnOff)
      if buttonZeroisOn {
            buttonZeroisOn = false
      } else  { buttonZeroisOn = true }
      
     case tiSimpleLinkBUT1UUID  :
         let buttonOnOff = buttonState(from: characteristic)
         print(buttonOnOff)
         print(buttonOneisOn)
         buttonOneState = buttonOnOff
      
      if buttonOneisOn {
            buttonOneisOn = false
      } else  { buttonOneisOn = true }
      
      print(buttonOneisOn)
   //  case BoardPeripheral.tiSimpleLinkDATAStreamUUID  :
    //  bytesToSend
   //   let data = Data(bytesToSend)

      //Using Characteristic 2AF1 with Properties WriteWithoutResponse
    //  peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
  //    print("doneStream")
  //    peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
 //     print("doneStream")
   //  case tiSimpleLinkDATAStringUUID  :
    //  bytesToSend
  //    let data = Data(bytesToSend)

      //Using Characteristic 2AF1 with Properties WriteWithoutResponse
   //   peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
      
  //    print("doneString")
      
   //   let _: Void = peripheral.readValue(for: characteristic)
     
 //     peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
  //    print("doneString")
  
 //     peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
//      print("doneString")
   
       default:
         print("Unhandled Characteristic UUID: \(characteristic.uuid)")
     }
      
   }  //UPDATE PERIPHERAL
   
   
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
   
   //MARK: Button State
    func buttonState(from characteristic: CBCharacteristic) -> String {
     guard let characteristicData = characteristic.value,
       let byte = characteristicData.first else { return "Error" }

     switch byte {
       case 0:
         
         return "Off"
         
       case 1: return "On"
       default:
         return "Reserved for future use"
     }
   }//Button State
   
   
   //MARK: write to the LEDs
   
//   private var bytesToSend: [UInt8] = [00, 01]
 //  let data = Data(bytesToSend)
   //    peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withoutResponse)
   
   func writetoGreenLED() {
    
      var byteToSend: [UInt8]
      
      print(greenLEDisOn)
   
      if (greenLEDisOn == true) {
         byteToSend = [00]
         greenLEDisOn = false
         greenLEDState = " OFF "
      } else {
         byteToSend = [01]
         greenLEDisOn = true
         greenLEDState = " ON  "
      }
      

      let data = Data(bytes: &byteToSend, count: 1)
   
      print(data)
      print(byteToSend)
 //     print("Green LED is ON/OFF")
         
      myPeripheral.writeValue(data, for: greenCharacteristic, type: .withoutResponse )
      print("Green LED is ON/OFF")
   }
   
   func writetoRedLED() {
    
      var byteToSend: [UInt8]
      
     print(greenLEDisOn)
      
      if (redLEDisOn == true) {
         byteToSend = [00]
         redLEDisOn = false
         redLEDState = " OFF  "
      } else {
         byteToSend = [01]
         redLEDisOn = true
         redLEDState = " ON   "
      }
      
      
      let data = Data(bytes: &byteToSend, count: 1)
      
      print(data)
      print(byteToSend)
   
    
         
      myPeripheral.writeValue(data, for: redCharacteristic, type: .withoutResponse )
      
      print("RED LED is ON/OFF")
 //     }
      
      }
      
   
 //   func writetoredLED( withValue: Data) {
      //Check if it has the right property
     // if characteristic.properties.contains(.writeWithoutResponse) && peripheral != nil {
  //       myPeripheral.writeValue(withValue, for: redCharacteristic, type: .withoutResponse )
    
//}//writeLED
   
   
} //BLEManagerClass
 



