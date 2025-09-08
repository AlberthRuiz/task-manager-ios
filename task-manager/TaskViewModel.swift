//
//  TaskViewModel.swift
//  task-manager
//
//  Created by Christiam Alberth Mendoza Ruiz on 8/09/25.
//

import Foundation

class TaskViewModel : ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(nombre: String, descripcion: String) {
        let newTask = Task(id: UUID(), nombre: nombre, descripcion: descripcion, completado: false)
        tasks.append(newTask)
    }
    
    func updateTask(task: Task, nombre: String, descripcion: String, completado: Bool) {
        if let index = self.tasks.firstIndex(where: {$0.id == task.id}) {
            tasks[index].nombre = nombre
            tasks[index].descripcion = descripcion
            tasks[index].completado = completado
        }
    }
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    func toggleCompletion( task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completado.toggle()
        }
    }
    
}

