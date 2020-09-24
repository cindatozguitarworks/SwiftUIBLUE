//
//  ContentView.swift
//  SwiftUIBLUE
//
//  Created by Cynthia Anderson on 9/9/20.
//

import SwiftUI

struct ContentView: View {
   
   @ObservedObject var bleManager = BLEManager()
   
   @State var ledRedState = false
  
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
              Label("Red Light   ", systemImage: "light.max")
               
               Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/
              ) {
               Text(bleManager.redLEDState)
              }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
              }.padding()
          
        
         //     Spacer()
         HStack {
         Label("Green Light  ", systemImage: "light.max")
            
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/
           ) {
               Text(bleManager.greenLEDState)
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            }.padding()

        // }//Hstack
            Spacer()
         
            HStack {
               
            Label("Button 0   ", systemImage: "guitars")
               
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                  Text(bleManager.buttonZeroState)
               }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
            }.padding() // HStack But0
            

         Spacer()
         
         HStack {
         Label("Button 1   ", systemImage: "guitars")
            
         Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
            Text(bleManager.buttonOneState)
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
