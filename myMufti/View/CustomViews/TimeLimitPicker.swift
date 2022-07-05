//
//  TimeLimitPicker.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 05/07/2022.
//

import SwiftUI

import SwiftUI

struct TimeLimitPicker: UIViewRepresentable {
    var data: [[String]]
    @Binding var selections: [Int]

    //makeCoordinator()
    func makeCoordinator() -> TimeLimitPicker.Coordinator {
        Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<TimeLimitPicker>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)

        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TimeLimitPicker>) {
        for i in 0...(self.selections.count - 1) {
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: TimeLimitPicker

        //init(_:)
        init(_ pickerView: TimeLimitPicker) {
            self.parent = pickerView
        }

        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }

        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }

        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }

        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component] = row
        }
    }
}

struct TimeLimitPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimeLimitPicker(data: [["1", "2"], ["1", "2"]], selections: .constant([1 ,1]))
    }
}
