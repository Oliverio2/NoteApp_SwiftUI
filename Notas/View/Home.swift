import SwiftUI

struct Home: View {
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>
    
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [], 
                  predicate: NSPredicate(format: "nota CONTAINS[c]  'Importante'"),
                  animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View{
        NavigationView{
            List{
                ForEach(results){
                    item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item   )
                        }){
                            Label(title:{
                                Text("Editar")
                            }, icon: {
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action:{
                            model.deleteData(item: item, contexto: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon: {
                                Image(systemName: "trash")
                            })
                        }                    }))
                }
            }.navigationTitle("Notas")
                .navigationBarItems(trailing:
                                        Button(action:{
                    model.show.toggle()
                }){
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundStyle(.blue)
                }
                ).sheet(isPresented: $model.show, content: {
                    addView(model: model)
                })
        }
    }
}
