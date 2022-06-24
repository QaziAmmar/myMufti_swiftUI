//
//  HelpView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import SwiftUI

struct HelpView: View {
    
    @StateObject var vm = HelpViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
    }
}

extension HelpView  {
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Change user Name")
            
            VStack {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.custom(Popins.medium.rawValue, size: 14))
                    CustomTextField(placeHolder: "UserName", text: $vm.email)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8).stroke(.gray))
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.custom(Popins.medium.rawValue, size: 14))
                    
                    GeometryReader { geometry in
                        TextEditor(text: $vm.description)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8).stroke(.gray))
                            .frame(height: geometry.size.height / 2)
                    }
                }
                
                Spacer()
                
                GreenBtn(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    vm.sendHelpEmail()
                }, title: "Submit")
            }.padding()
   
        }
    }
}


struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
