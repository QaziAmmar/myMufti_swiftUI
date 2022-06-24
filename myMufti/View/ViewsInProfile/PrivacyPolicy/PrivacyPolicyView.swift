//
//  PrivacyPolicyView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 24/06/2022.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let text1 = """
                    At Apple, we believe strongly in fundamental privacy rights — and that those fundamental rights should not differ depending on where you live in the world. That’s why we treat any data that relates to an identified or identifiable individual or that is linked or linkable to them by Apple as “personal data,” no matter where the individual lives. This means that data that directly identifies you — such as your name is personal data, and also data that does not directly identify you, but that can reasonably be used to identify you — such as the serial number of your device — is personal data.
                    """
    let text2 = """
At Apple, we respect your ability to know, access, correct, transfer, restrict the processing of, and delete your personal data. We have provided these rights to our global customer base and if you choose to
    exercise these privacy rights, you have the right not to be treated in a discriminatory way nor to receive a lesser degree of service from Apple. Apple does not sell your data including as “sale” is defined in Nevada and California.
"""
    
    var body: some View {
        loadView()
    }
    
}

extension PrivacyPolicyView {
    
    func loadView() -> some View {
        VStack() {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, titile: "Privacy Policy")
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("What Is Personal Data at Apple?")
                        .font(.custom(Popins.bold.rawValue, size: 10))
                    Text(text1)
                        .font(.custom(Popins.regular.rawValue, size: 10))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Privacy Rights at Apple")
                        .font(.custom(Popins.bold.rawValue, size: 10))
                    Text(text2)
                        .font(.custom(Popins.regular.rawValue, size: 10))
                }.padding(.top, 20)
            }.padding()
        }
    }
    
}


struct PrivacyPolicyView_Previews : PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
