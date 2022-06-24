//
//  SignUpView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct SignUpView: View {
    
    
    @ObservedObject var vm = SignUpViewModel()

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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

extension SignUpView {
    
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
                sepratorView()
                GSignInButton(errorMessage: $vm.errorMessage, showError: $vm.showError)
                bottomView()
                
            }.padding([.leading, . trailing], 10)
                .background(Color.white
                    .opacity(0.8)
                    .cornerRadius(10)
                    .ignoresSafeArea())
        }
        
        
    } // View
    

    
}

// MARK: - View Extension
extension SignUpView {
    
    func pageTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Welcome")
                .font(Font.custom(Popins.bold.rawValue, size: 24))
            Text("Follow the steps below to create your account")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 10))
        }.padding([.top, .bottom])
    }
    
    
    func textFieldView() -> some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 10) {
                
                CustomTextField(placeHolder: "User name", text: $vm.userName)
                CustomTextField(placeHolder: "Email", text: $vm.email)
                CustomTextField(placeHolder: "Password", text: $vm.password, isSecure: true)
                CustomTextField(placeHolder: "Retype Password", text: $vm.retypePassword, isSecure: true)
                
                HStack(alignment: .top) {
                    Spacer()
                    BlackButton(action: {
                        vm.SignUpUser()
                    }, title: "Sign up")
                }
            } // TextField StackView
            
        }
    }
    
    func forgotPasswordBtn() -> some View {
        
        NavigationLink(destination:
                        ForgotEmailView()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
                       
        ) {
            Text("Forgot Password?")
                .foregroundColor(.black)
                .font(Font.custom(Popins.semiBold.rawValue, size: 12))
                .padding()
        }
    }
    
    
    func sepratorView() -> some View {
        HStack {
            
            Color.gray.frame(height: 1)
            Text("or")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 18))
            Color.gray.frame(height: 1)
            
        }.padding([.leading, .trailing])
    }
    
    
    func bottomView() -> some View {
        
        HStack {
            
            Spacer()
            
            Text("Already have a account?")
                .font(Font.custom(Popins.regular.rawValue, size: 14))
            
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Login")
                    .foregroundColor(.black)
                    .font(Font.custom(Popins.bold.rawValue, size: 14))
            }.padding([.trailing, .top, .bottom])

            Spacer()
        }

    }
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
