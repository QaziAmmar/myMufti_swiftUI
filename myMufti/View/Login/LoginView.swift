//
//  LoginVew.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 20/06/2022.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var vm = LoginViewModel()
    @State private var moveToForgot = false
    
    var body: some View {
        
        ZStack {
            bgImg()
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        }).onReceive(UserDefaultManager.moveToLogin, perform: { newValue in
            moveToForgot = false
            vm.showError = true
            vm.errorMessage = "Password change successful"
        })
    }
}

//MARK: - View Extension

extension LoginView {
    
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
    
   
    
    func bottomView() -> some View {
        
        HStack {
            
            Spacer()
            
            Text("Don’t have an account?")
                .font(Font.custom(Popins.regular.rawValue, size: 14))
            
            NavigationLink(destination:
                            SignUpView()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true) ) {
                    Text("Signup")
                        .foregroundColor(.black)
                        .font(Font.custom(Popins.bold.rawValue, size: 14))
                }.padding([.trailing, .top, .bottom])
            Spacer()
        }

    }
    
}

// MARK: - View Extension
extension LoginView {
    
    func pageTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Log In")
                .font(Font.custom(Popins.bold.rawValue, size: 24))
            Text("Enter your email and password to continue")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 10))
        }.padding([.top, .bottom])
    }
    
    
    func textFieldView() -> some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 10) {
                
                CustomTextField(placeHolder: "Email", text: $vm.email)
                CustomTextField(placeHolder: "Password", text: $vm.password, isSecure: true)
                
                HStack(alignment: .top) {
                    forgotPasswordBtn()
                    Spacer()
                    BlackButton(action: {
                        vm.loginUser()
                    }, title: "Login")
                }
            } // TextField StackView
        }
    }
    
    func forgotPasswordBtn() -> some View {
        
        NavigationLink(destination: HideNavbarOf(view: ForgotEmailView()), isActive: $moveToForgot) {
                Text("Forgot Password?")
                    .foregroundColor(.black)
                    .font(Font.custom(Popins.semiBold.rawValue, size: 12))
                    .padding([.leading, .trailing, .bottom])
            }
        
//        NavigationLink(destination:
//                        ForgotEmailView()
//            .navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
//
//        ) {
//            Text("Forgot Password?")
//                .foregroundColor(.black)
//                .font(Font.custom(Popins.semiBold.rawValue, size: 12))
//                .padding([.leading, .trailing, .bottom])
//        }
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
    
    
    
}



struct LoginVIew_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
