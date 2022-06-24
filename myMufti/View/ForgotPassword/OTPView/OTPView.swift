//
//  OTPView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 23/06/2022.
//
import SwiftUI

struct OTPView: View {
    
    @ObservedObject var vm = OTPViewModel()
    var email  = ""
    var maxDigits: Int = 4
    
    @State var pin: String = ""
    @State var showPin = false
    @State var isDisabled = true
    

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

extension OTPView {
    
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
                    .padding(.bottom, 50)

            }.padding([.leading, . trailing], 10)
                .background(Color.white
                    .opacity(0.8)
                    .cornerRadius(10)
                    .ignoresSafeArea())
        }
    } // View
    
}

// MARK: - View Extension
extension OTPView {
    
    func pageTitle() -> some View {
        VStack(alignment: .leading) {
            Text("Email Verification")
                .font(Font.custom(Popins.bold.rawValue, size: 24))
            Text("Please enter the 4-digit code send to you at")
                .foregroundColor(Color(ColorName.appGray.rawValue))
                .font(Font.custom(Popins.medium.rawValue, size: 10))
            Text(email)
                .foregroundColor(.black)
                .font(Font.custom(Popins.bold.rawValue, size: 10))
            
        }.padding([.top, .bottom])
    }
    
    func textFieldView() -> some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 10) {

                ZStack {
                    backgroundField
                    pinDots
                }
                hiddenNavigationLinks
                
                HStack(alignment: .top) {
                    Spacer()
                    BlackButton(action: {
                        vm.sendOTP(at: email)
                    }, title: "Change Password")
                }
            } // TextField StackView
        }
    }
    
    
    private var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: CreateNewPasswordView(userId: vm.userId)), isActive: $vm.movetoCreateNewPassword)
        }
        .hidden()
        .frame(height: 0)
    }
    
}

// MAKR: - OTPView
extension OTPView {
    
    private var pinDots: some View {
        HStack(spacing: 20) {
//             Spacer()
             ForEach(0..<maxDigits) { index in
                 VStack {
                     Text(getPin(at: index))
                         .font(.custom(Popins.bold.rawValue, size: 20))
                         .frame( height: 30)
                     RoundedRectangle(cornerRadius: 10)
                         .frame(width: 56, height: 2)
                         .foregroundColor(.gray)
                     
                 }
                 
//                 Spacer()
             }
         }
     }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: {self.pin}, set: {newValue in
            self.pin = newValue
            vm.otpCode = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)
            .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)

    }
    
    private func getPin(at index: Int) -> String {
        if index < pin.count {
            let Rangeindex = pin.index(pin.startIndex, offsetBy: index)
            return String(pin[Rangeindex])
        } else {
            return ""
        }
     }
    
    private func submitPin() {
        
        isDisabled = true
        
        if pin.count == maxDigits {
            isDisabled = false
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
              // max digits, we remove the additional characters and make a recursive call.
      if pin.count > maxDigits {
          pin = String(pin.prefix(maxDigits))
          submitPin()
      }
    }
}



struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
