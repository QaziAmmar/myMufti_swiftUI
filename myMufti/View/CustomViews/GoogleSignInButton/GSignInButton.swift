//
//  GSignInButton.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct GSignInButton: View {
    

    @Binding var errorMessage: String
    @Binding var showError: Bool
    
    @ObservedObject var vm = GSignInViewModel()

    
    var body: some View {
        Button  {

            vm.signIn()
            
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 45)
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    Image(ImageName.google.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Log in with Google")
                        .foregroundColor(.black)
                        .opacity(0.5)
                        .font(Font.custom(Popins.medium.rawValue, size: 18))
                }
            }.padding([.leading, .trailing])
        }.onAppear {
            errorMessage = vm.errorMessage
            showError = vm.showError
        }
    }
}

struct GSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GSignInButton(errorMessage: .constant("GSign In error"), showError: .constant(false))
    }
}
