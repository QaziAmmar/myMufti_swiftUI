//
//  ProfileRow.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 08/03/2022.
//

import SwiftUI


struct ProfileRow<Destination: View>: View {
    
    var label = ""
    var destination: Destination
    
    var body: some View {

        
        NavigationLink {
            destination
        } label: {
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundColor(.white)
                VStack {
                    Spacer()
                    HStack {
                        Text(label)
                            .font(.custom(Popins.regular.rawValue, size: 16))
                            .foregroundColor(.black)
                            
                        Spacer()

                        Image(systemName: "chevron.forward")
                            .foregroundColor(.black)

                    }
                    .padding([.leading, .trailing])
                    Spacer()
                    Divider()
                        .frame(height: 0.4)
                        .background(Color.gray.opacity(0.5))
                }
            
            }
            .frame(height: 56)
        }

        
            
//        Button  {
//            self.action()
//        } label: {
//
//        }
        
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(label: "Ammar", destination: Text("New View"))
    }
}
