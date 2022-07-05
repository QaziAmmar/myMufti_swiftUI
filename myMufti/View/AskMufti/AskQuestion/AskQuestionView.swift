//
//  AskQuestionView.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 27/06/2022.
//

// add binding variable into the filter view.
// with name of f_selectedCategory and f_experience


import SwiftUI

struct AskQuestionView: View {
    
    @StateObject var vm = AskQuestionViewModel()
    @State private var date = Date()
    @State private var isPickerVisible = false
    @State private var isFilterVisable = false
    @State private var selectedMuftiName = ""
    @State private var filterArray = [String]()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            loadView()
        }.alert(isPresented: $vm.showError, content: {
            Alert(title: Text(vm.errorMessage))
        })
        .sheet(isPresented: $isPickerVisible, content: {
            DatePicker("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
            
        }).onChange(of: date) { newValue in
            vm.date = newValue
            isPickerVisible.toggle()
        }
        .onChange(of: selectedMuftiName, perform: { newValue in
            if newValue.isEmpty {
                vm.muftiId = ""
            }
        })
        .sheet(isPresented: $isFilterVisable, content: {
            FilterView(filterArray: $filterArray, selectedCategory: $vm.f_selectedCategory, selectedExperience: $vm.f_selectedExperience).onDisappear {
                if !(vm.searchText.isEmpty) {
                    vm.getAllMuftiesApi()
                }
                selectedMuftiName = ""
                
            }
        })
        
    }
}

// MARK: - View Extension
extension AskQuestionView  {
    
    func loadView() -> some View {
        
        VStack {
            
            Text("Ask Mufties")
                .font(.custom(Popins.bold.rawValue, size: 16))
                .padding([.top])
            
            
                VStack(spacing: 30) {
                    
                    VStack(alignment: .leading) {
                        SearchBar(text: $vm.searchText) {
                            isFilterVisable = true
                        }
                        
                        // show the selected item that will be use for mufti filter search
                        filteredItemView()
                    }
            
                    if vm.searchText.isEmpty {
                        questionView()
                    } else {
                        // mufti list view
                        muftiListView()
                    }
                }.padding()

        }
    }
    
    
    
    func questionView() -> some View {
        VStack(spacing: 20) {
            
            // Start Description View
            ZStack(alignment: .topLeading) {
                
                if vm.question_detail.isEmpty {
                    Text("Write your question here")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                TextEditor(text: $vm.question_detail)
                    .font(.custom(Popins.regular.rawValue, size: 16))
                    .frame(height: 75)
                    .opacity(vm.question_detail.isEmpty ? 0.1 : 1)
            }
            .font(.custom(Popins.regular.rawValue, size: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(.gray)
            )
            // End Description
            
            if (!hideCategoryView()) {
                Menu {
                    ForEach(vm.categories, id: \.self){ category in
                        Button(category) {
                            vm.selectedCategory = category
                        }
                    }
                } label: {
                    DropDownBtn(text: vm.selectedCategory.isEmpty ? "Select Category" : vm.selectedCategory, image: ImageName.dropDownIcon.rawValue)
                }
            }
            
            DropDownBtn(text: DateManager.standard.getString(from: date), image: ImageName.calendar.rawValue) {
                isPickerVisible = true
            }
            
            Spacer()
            
            GreenBtn(action: {
                self.presentationMode.wrappedValue.dismiss()
                vm.sendQuestion()
            }, title: "Send")
        }
    }
    
    
    func muftiListView() -> some View {
        VStack {
            ScrollView {
                if vm.mufties.count == 0 {
                    Text("No Mufti Found")
                        .font(.custom(Popins.regular.rawValue, size: 24))
                } else {
                    ForEach(vm.mufties) { mufti in
                        MuftiRow(mufti: mufti) {
                            vm.searchText = ""
                            vm.muftiId = mufti.id
                            
                            if !selectedMuftiName.isEmpty {
                                filterArray.remove(at: filterArray.firstIndex(of: selectedMuftiName)!)
                            }
                            selectedMuftiName = mufti.name
                            filterArray.append(selectedMuftiName)
                            
                        }
                    }
                }
            }.onChange(of: vm.searchText) { newValue in
                vm.getAllMuftiesApi()
            }
        }
    }
    
    /// filter view shows the selected items under the search bar
    func filteredItemView() -> some View {
        HStack {
            ForEach(filterArray, id: \.self) { item in
                ZStack(alignment: .topTrailing) {
                    Text(item)
                        .padding([.top], 10)
                        .padding([.trailing, .leading])
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 7, height: 7)
                        .padding([.trailing, .top], 5)
                }
                .onTapGesture {
                    
                    if item == vm.f_selectedExperience {
                        vm.f_selectedExperience = ""
                    }
                    
                    if item == vm.f_selectedCategory {
                        vm.f_selectedCategory = ""
                    }
                    
                    if item == selectedMuftiName {
                        selectedMuftiName = ""
                    }
                    
                    filterArray.remove(at: filterArray.firstIndex(of: item)!)
                    vm.getAllMuftiesApi()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray)
                )
            }
        }
    }
    
    
    func hideCategoryView() -> Bool {
        
        if !(selectedMuftiName.isEmpty) || (filterArray.count != 0) {
            return true
        }
        
        return false
    }
    
}

struct AskQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        AskQuestionView()
    }
}
