import Foundation
import CoreData
import SwiftUI
import Combine

class ViewModel: ObservableObject{
   @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem: Notas!
    
    // Core Data
    
    func saveData(contexto: NSManagedObjectContext){
        let newNota = Notas(context: contexto)
        newNota.nota = nota
        newNota.fecha = fecha
        
        do {
            try contexto.save()
            print("Guardó")
            show.toggle()
        } catch let error as NSError {
            // Alerta al usuario
            print("No guardó", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, contexto: NSManagedObjectContext ){
        contexto.delete(item)
        //try! contexto.save()
        do {
            try contexto.save()
            print("Eliminó")
        } catch let error as NSError {
            // Alerta al usuario
            print("No eliminó", error.localizedDescription)
        }
        
    }
    
    func sendData(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
        
    }
    func editData(contexto: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try contexto.save()
            print("Editó")
            show.toggle()
        } catch let error as NSError {
            print("No editó")
        }
    }
}
