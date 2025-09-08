//
//  Task.swift
//  task-manager
//
//  Created by Christiam Alberth Mendoza Ruiz on 8/09/25.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    var nombre: String
    var descripcion: String
    var completado: Bool
    
    init(id: UUID, nombre: String, descripcion: String, completado: Bool) {
        self.id = id
        self.nombre = nombre
        self.descripcion = descripcion
        self.completado = completado
    }
}
