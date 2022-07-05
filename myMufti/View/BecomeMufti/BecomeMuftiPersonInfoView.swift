//
//  BecomeMuftiPersonInfoView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct BecomeMuftiPersonInfoView: View {
    
    
    @State private var showError = false
    @State private var name = ""
    @State private var phone = ""
    @State private var errorMessage = ""
    @State private var isActiveMoveToEduView = false
    
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $showError, content: {
            Alert(title: Text(errorMessage))
        })
    }
}

// MARK: - View Extension
extension BecomeMuftiPersonInfoView  {
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                presentationMode.wrappedValue.dismiss()
            }, titile: "Become A Mufti")
            
            VStack (spacing: 30){
                
                
                
                
                Image(ImageName.infoProgress.rawValue)
                    .resizable()
                    .frame(height: 30)
                
                HStack {
                    Image(ImageName.actionImage.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Please enter name and phone number and click next")
                        .foregroundColor(.gray)
                        .font(.custom(Popins.regular.rawValue, size: 10))
                    Spacer()
                }
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Name")
                        .foregroundColor(.gray)
                    
                    CustomTextField(placeHolder: "Enter your Name", text: $name, isSecure: false)
                        .shadow(color: .gray, radius: 2)

                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Phone Number")
                        .foregroundColor(.gray)
                    
                    CustomTextField(placeHolder: "Enter your Phone", text: $phone, isSecure: false)
                        .shadow(color: .gray, radius: 2)
                        .keyboardType(.numberPad)

                }
                
                Spacer()
                hiddenView()
                
                GreenBtn(action: {
                    self.moveToEducationVew()
                }, title: "Next")
                
            }.padding()
        }
        
    }
    
    
    func hiddenView() -> some View {
        NavigationLink(destination: HideNavbarOf(view: BecomeMuftiEduView(name: name, phone: phone)), isActive: $isActiveMoveToEduView) {
            EmptyView()
        }.hidden()
    }
    
}


extension BecomeMuftiPersonInfoView {
    
    // Move to education View
    func moveToEducationVew()  {
        if validationCheck() {
            isActiveMoveToEduView = true
        }
    }
    
    // Move to validation Check View
    func validationCheck() -> Bool {
        if name.isEmpty {
            showError = true
            errorMessage = "Please enter your Name"
            return false
        }
        
        if phone.isEmpty {
            showError = true
            errorMessage = "Please enter your Phone"
            return false
        }
        
        return true
        
    }
    
}


struct BecomeMuftiPersonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        BecomeMuftiPersonInfoView()
    }
}
