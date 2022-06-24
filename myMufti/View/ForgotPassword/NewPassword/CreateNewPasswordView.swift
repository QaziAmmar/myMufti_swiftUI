//
//  CreateNewPasswordView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//

import SwiftUI


struct CreateNewPasswordView: View {
    
    @ObservedObject var vm = CreateNewPasswordViewModel()
    var userId = String()
    var body: some View {
        
        ZStack {
            bgImg()
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
    }
}

//MARK: - View Extension

extension CreateNewPasswordView {
    
    func bgImg() -> some View {
        Image("signUpBackground")
            .resizable()
            .ignoresSafeArea()
    }
    
    func loadView() -> some View {
        
        // Main Stack
        VStack {
            
            Spacer()
            VStack(alignment: .leading) {
                
                pageTitle()
                textFieldView()
                
            }.padding([.leading, . trailing], 10)
                .background(Color.white
                    .opacity(0.8)
                    .cornerRadius(10)
                    .ignoresSafeArea())
        }
        
        
    } // View
    
}

// MARK: - View Extension
extension CreateNewPasswordView {
    
    func pageTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Create new password")
                .font(Font.custom(Popins.bold.rawValue, size: 24))
            Text("Enter new password")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 10))
        }.padding([.top, .bottom])
    }
    
    
    func textFieldView() -> some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 10) {
                
                CustomTextField(placeHolder: "Passwrod", text: $vm.password, isSecure: true)
                CustomTextField(placeHolder: " Retype Password", text: $vm.retype_password, isSecure: true)
                
                HStack(alignment: .top) {
                    
                    Spacer()
                    BlackButton(action: {
                        
                        vm.changePassword(userId: userId)
                        
                    }, title: "Change")
                }
            } // TextField StackView
        }
    }
}


struct CreateNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPasswordView()
    }
}
