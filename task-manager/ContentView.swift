//
//  ContentView.swift
//  task-manager
//
//  Created by Christiam Alberth Mendoza Ruiz on 8/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var showingAddTask = false
    @State private var selectedTask: Task?
    @State private var showingUpdateTask = false
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.tasks.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("No hay tareas")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        Text("Agrega tu primera tarea usando el botón +")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.tasks) { task in  
                            TaskRowView(
                                task: task,
                                onToggleCompletion: {
                                    viewModel.toggleCompletion(task: task)
                                },
                                onEdit: {
                                    selectedTask = task
                                    showingUpdateTask = true
                                }
                            )
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Mis Tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTask = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingUpdateTask) {
            if let task = selectedTask {
                UpdateTaskView(viewModel: viewModel, task: task)
            }
        }
    }
}

struct TaskRowView: View {
    let task: Task
    let onToggleCompletion: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        HStack {

            Button(action: onToggleCompletion) {
                Image(systemName: task.completado ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.completado ? .green : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
             VStack(alignment: .leading, spacing: 4) {
                Text(task.nombre)
                    .font(.headline)
                    .strikethrough(task.completado)
                    .foregroundColor(task.completado ? .secondary : .primary)
                
                if !task.descripcion.isEmpty {
                    Text(task.descripcion)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
                    .font(.body)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
