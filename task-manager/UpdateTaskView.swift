//
//  UpdateTaskView.swift
//  task-manager
//
//  Created by Christiam Alberth Mendoza Ruiz on 8/09/25.
//

import SwiftUI

struct UpdateTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    let task: Task
    @State private var nombre: String
    @State private var descripcion: String
    @State private var completado: Bool
    @State private var showingAlert = false
    
    init(viewModel: TaskViewModel, task: Task) {
        self.viewModel = viewModel
        self.task = task
        self._nombre = State(initialValue: task.nombre)
        self._descripcion = State(initialValue: task.descripcion)
        self._completado = State(initialValue: task.completado)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información de la tarea")) {
                    TextField("Nombre de la tarea", text: $nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Descripción (opcional)", text: $descripcion, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .lineLimit(3...6)
                }
                
                Section(header: Text("Estado")) {
                    Toggle("Tarea completada", isOn: $completado)
                        .toggleStyle(SwitchToggleStyle(tint: .green))
                }
                
                Section {
                    Button("Actualizar Tarea") {
                        updateTask()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(nombre.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(10)
                    .disabled(nombre.isEmpty)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Editar Tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
        .alert("Campo requerido", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text("El nombre de la tarea es obligatorio")
        }
    }
    
    private func updateTask() {
        let trimmedNombre = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescripcion = descripcion.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedNombre.isEmpty {
            showingAlert = true
            return
        }
        
        viewModel.updateTask(
            task: task,
            nombre: trimmedNombre,
            descripcion: trimmedDescripcion,
            completado: completado
        )
        dismiss()
    }
}

#Preview {
    let sampleTask = Task(
        id: UUID(),
        nombre: "Tarea de ejemplo",
        descripcion: "Esta es una descripción de ejemplo",
        completado: false
    )
    return UpdateTaskView(viewModel: TaskViewModel(), task: sampleTask)
}
