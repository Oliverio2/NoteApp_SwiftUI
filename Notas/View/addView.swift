import SwiftUI

struct addView: View {
    @ObservedObject var model : ViewModel
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Editar nota" : "Agregar nota")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccionar fecha", selection: $model.fecha)
            Spacer()
            Button(action:{
                if model.updateItem != nil{
                    model.editData(contexto: context)
                }else{
                    model.saveData(contexto: context)
                }
            }){
                Label(
                    title: { Text("Guardar").foregroundStyle(.white).bold()},
                    icon: { Image(systemName: "plus").foregroundStyle(.white) }
                )
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(model.nota == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
        }.padding()
    }
}
