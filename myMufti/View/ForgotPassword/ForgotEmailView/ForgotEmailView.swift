//
//  ForgotEmailView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//


import SwiftUI

struct ForgotEmailView: View {
    
    @ObservedObject var vm = ForgotEmailViewModel()
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

extension ForgotEmailView {
    
    func bgImg() -> some View {
        Image("signUpBackground")
            .resizable()
            .ignoresSafeArea()
    }
    
    func loadView() -> some View {
        
        // Main Stack
        VStack {
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            })
            
            Spacer()
            VStack(alignment: .leading) {
                
                pageTitle()
                textFieldView()
                    .padding(.bottom, 50)
                
                hiddenNavigationLinks

            }.padding([.leading, . trailing], 10)
                .background(Color.white
                    .opacity(0.8)
                    .cornerRadius(10)
                    .ignoresSafeArea())

        }
    } // View
    
}

// MARK: - View Extension
extension ForgotEmailView {
    
    func pageTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Forgot Password")
                .font(Font.custom(Popins.bold.rawValue, size: 24))
            Text("If you need help resetting your password we can help by sending you a link to reset it.")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 10))
        }.padding([.top, .bottom])
    }
    
    func textFieldView() -> some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 10) {
                
                CustomTextField(placeHolder: "Email", text: $vm.email)
                
                HStack(alignment: .top) {
                    Spacer()
                    BlackButton(action: {
                        vm.sendOTP {
                            // move to next screen
                        }
                    }, title: "Next")
                }
            } // TextField StackView
        }
    }
    
    
    private var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: OTPView(email: vm.email)), isActive: $vm.moveToOPTScreen)
        }
        .hidden()
        .frame(height: 0)
    }
    
}

struct ForgotEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotEmailView()
    }
}
