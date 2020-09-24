//
//  ContentView.swift
//  SwiftUIBLUE
//
//  Created by Cynthia Anderson on 9/9/20.
//

import SwiftUI

struct ContentView: View {
   
   @ObservedObject var bleManager = BLEManager()
   
  
    var body: some View {
      VStack (spacing: 10) {
         
         Text("Tau-6")
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .center)
         
        List(bleManager.peripherals){
    peripheral in
            HStack{
         Text(peripheral.name)
           Spacer()
           Text(String(peripheral.rssi))
        }
        }//.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
         //.frame(height: 300) //list
         
    //     Spacer()
 //        Spacer()
           
        VStack {
           VStack (spacing: 10){
            
           HStack {
            Text("Red Light  ")
            
            Button(action: {
               self.bleManager.writetoRedLED()
          
            }){
               Text(bleManager.redLEDState)
           
             Label("", systemImage:
                 bleManager.redLEDisOn ? "circle.fill" : "circle" )
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            //red Light
  
            }.padding()
          
 
            HStack {
               
               Text("Green Light  ")
               
               Button(action: {
                  self.bleManager.writetoGreenLED()
              
               }){
                  Text(bleManager.greenLEDState)
                //   Text(bleManager.buttonZeroState)
                Label("", systemImage:
                    bleManager.greenLEDisOn ? "circle.fill" : "circle" )
               }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
               //Green Light
               
           }.padding() // HStack Green Light

        // }//Hstack
            Spacer()
         
            HStack {
               
            Text("Button 0   ") //"guitars")
               
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                  Text(bleManager.buttonZeroState)
               Label("", systemImage:
                   bleManager.buttonZeroisOn ? "circle" : "circle.fill" )
               }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            }.padding() // HStack But0
      

         Spacer()
         
         HStack {
     
         Text("Button 1   " )

        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
         Text(bleManager.buttonOneState)
        Label("", systemImage:
             bleManager.buttonOneisOn ? "circle" : "circle.fill" )
         }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
         }.padding()  //HStack But1
         
         Spacer()
     
      HStack{
         HStack (spacing: 10){
            
            Button(action: {
               self.bleManager.startScanning()
           //    print(" Start Scanning")
            }){
               Text("Start Scan   ")
            } //Start Button
            
           Button(action: {
               self.bleManager.stopScanning()
           //    print(" Stop Scanning")
           }){
              Text("  Stop Scan")
            } //Stop Button
      }.padding()  //Vstack
         
          //     VStack (spacing: 10){
          //        Button(action: {
          //           print(" Start Advertising")
          //        }){
          //           Text("Start Advertising")
           //       }
          //        Button(action: {
          //           print(" Stop Advertising")
           //       }){
          //           Text("Stop Advertising")
         //         }
        //    }.padding()  //Vstack
      }
    //  .font(.body)
      .alignmentGuide(.lastTextBaseline) { dimension in 6 }
      .padding()
         
         }
   }//VSTACK
      .font(.title)
      .frame(maxWidth: .infinity, alignment: .center)
      
      }
      
    }//body
   
    }//content

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
