//
//  AddTaskView.swift
//  task-manager
//
//  Created by Christiam Alberth Mendoza Ruiz on 8/09/25.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var nombre: String = ""
    @State private var descripcion: String = ""
    @State private var showingAlert = false
    
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
                
                Section {
                    Button("Guardar Tarea") {
                        saveTask()
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
            .navigationTitle("Nueva Tarea")
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
    
    private func saveTask() {
        let trimmedNombre = nombre.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescripcion = descripcion.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedNombre.isEmpty {
            showingAlert = true
            return
        }
        
        viewModel.addTask(nombre: trimmedNombre, descripcion: trimmedDescripcion)
        dismiss()
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
}
