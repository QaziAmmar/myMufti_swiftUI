//
//  ChangeUserName.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import SwiftUI

struct ChangeUserName: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = ChangeUserNameViewModel()
    @Binding var userName: String
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
    }
}

// View Extension
extension ChangeUserName {
    
    func bgImg() -> some View {
        Image(ImageName.signUpBgImg.rawValue)
            .resizable()
            .ignoresSafeArea()
    }
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Change user Name")
            
            VStack {
                CustomTextField(placeHolder: "UserName", text: $userName)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.gray))
                Spacer()
                
                GreenBtn(action: {
                    vm.username = userName
                    vm.chnageUsername {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }, title: "Change Username")
            }.padding()
   
        }
    }
    
}


struct ChangeUserName_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUserName(userName: .constant("Ammar"))
    }
}
