//
//  ProfileView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 20/06/2022.
//

import SwiftUI


struct ProfileView: View {
    
    @ObservedObject var vm = ProfileViewModel()
    @State private var showNotification = true
    @State private var movetoChangeUserName = false
    @State private var movetoChangePassword = false
    @State private var showImagePicker = false
    @State private var isSharePresented: Bool = false
    
    let items = [URL(string: "https://www.apple.com")!]
    
    
    var body: some View {
        
        ZStack {
            ScrollView {
                loadView()
            }
        }.background(
            // add hidder Navigation links
            hiddenNavigationLinks
        )
        .onAppear {
            showAPILoader = true
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePickerView(sourceType: .photoLibrary) { image in
                vm.updateImage(image: image)
            }
        })
        .sheet(isPresented: $isSharePresented, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [URL(string: "https://www.apple.com")!])
        })
        
        
    }
}

// View Extension
extension ProfileView {
    func loadView() -> some View {
        
        VStack {
            profileDetail()
                .padding([.top], 5)
                .padding([.bottom], 25)
            
            
            VStack(spacing: 0) {
                
                
                VStack(spacing: 0) {
                    ProfileRow(label: "My Queries",
                               destination: HideNavbarOf(view: MyQuriesView() ) )
                    
                    ProfileRow(label: "Meetings",
                               destination: HideNavbarOf(view: MeetingView() ) )
                    
                }.padding(.bottom)
                
                VStack(spacing: 0) {
                    ProfileRow(label: "Change Username",
                               destination: HideNavbarOf(view: ChangeUserName(userName: $vm.username)))
                    
                    ProfileRow(label: "Change Password",
                               destination: HideNavbarOf(view: ChangePasswordView() ) )
                    
                }.padding(.bottom)
                
                VStack() {
                    
                    ProfileRow(label: "Notification",
                               destination: HideNavbarOf(view: NotificationView() ) )
                }.padding(.bottom)
                
                
                VStack(spacing: 0) {
                    
                    ProfileRow(label: "Categories",
                               destination: HideNavbarOf(view: Text("Categories") ))
                    shareBtn
                    
                    ProfileRow(label: "Privacy Policy",
                               destination: HideNavbarOf(view: PrivacyPolicyView() ))
                    
                    ProfileRow(label: "Help & Feedback",
                               destination: HideNavbarOf(view: HelpView() ) )
                    
                }.padding(.bottom)
                //
                VStack(spacing: 0) {
                    premiumBtn
                }.padding(.bottom)
                
                logOutBtn
                    .padding(.bottom)
                
            }.background(Color.ligh_gray().opacity(0.2))
            
        }.padding([.top], 30)
        
    }
    
    func profileDetail() -> some View {
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                Button {
                    showImagePicker.toggle()
                } label: {
                    AsyncImage(url: URL(string: vm.userImg)) { image in
                        image
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                    } placeholder: {
                        Image(ImageName.person_placeholder.rawValue)
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    }
                }
                
                Button  {
                    showImagePicker.toggle()
                } label: {
                    Image(ImageName.image_picker.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            
            Text(vm.username)
                .font(Font.custom(Popins.medium.rawValue, size: 18))
            
        }
    }
    
    private var logOutBtn: some View {
        
        Button  {
            vm.logoutUser()
        } label: {
            ZStack() {
                Rectangle()
                    .foregroundColor(.white)
                
                VStack {
                    HStack {
                        Text("Log Out")
                            .foregroundColor(Color.red)
                            .font(Font.system(size: 16))
                        Spacer()
                    }
                    .padding([.leading, .trailing])
                }
            }.frame(height: 56)
        }
    }
    
    private var premiumBtn: some View {
        Button  {
            print("get premium btn")
        } label: {
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundColor(.white)
                VStack {
                    Spacer()
                    HStack {
                        Text("Get Premium")
                            .font(.custom(Popins.semiBold.rawValue, size: 16))
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Image(ImageName.premium.rawValue)
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                    }
                    .padding([.leading, .trailing])
                    Spacer()
                    Divider()
                        .frame(height: 0.5)
                        .background(Color.gray)
                }
                
            }
            .frame(height: 56)
        }
    }
    
    private var shareBtn: some View {
        
        Button  {
            self.isSharePresented.toggle()
        } label: {
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundColor(.white)
                VStack {
                    Spacer()
                    HStack {
                        Text("Share / Invite")
                            .font(.custom(Popins.regular.rawValue, size: 16))
                            .foregroundColor(.black)
                            
                        Spacer()

                        Image(systemName: "chevron.forward")
                            .foregroundColor(.black)

                    }
                    .padding([.leading, .trailing])
                    Spacer()
                    Divider()
                        .frame(height: 0.4)
                        .background(Color.gray.opacity(0.5))
                }
            
            }
            .frame(height: 56)
        }
    }
    
    
    private var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: ChangeUserName(userName: $vm.username)), isActive: $movetoChangeUserName)
            NavigationLink("", destination: HideNavbarOf(view: ChangePasswordView()), isActive: $movetoChangePassword)
        }
        .hidden()
        .frame(height: 0)
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
