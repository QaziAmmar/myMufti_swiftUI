//
//  ChangePasswordView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//


import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var vm = ChangePasswordViewModel()
    
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
    }
}


// View Extension
extension ChangePasswordView {
    
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Change Password")
            
            VStack {
                
                CustomTextField(placeHolder: "Enter old password", text: $vm.old_password, isSecure: true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.gray))
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                CustomTextField(placeHolder: "Enter new password", text: $vm.password, isSecure: true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.gray))
                CustomTextField(placeHolder: "Retype new password", text: $vm.retype_password, isSecure: true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8).stroke(.gray))

                Spacer()
                
                GreenBtn(action: {

                    vm.changePassword {
                        // if password change successfull then move to back
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    
                }, title: "Change password")
            }.padding()
        }
    }
    
}


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
