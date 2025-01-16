//
// File: ContentView.swift
// Project: TaskManager
// 
// Created by SCOTT CROWDER on 1/16/25.
// 
// Copyright © Playful Logic Studios, LLC 2025. All rights reserved.
// 


import SwiftUI

struct Task: Identifiable {
    let id: UUID = UUID()
    let name: String
    var isComplete: Bool
}

struct ContentView: View {
    
//    @State private var tasks: [String] = ["Buy groceries", "Walk dog", "Wash car"]
    @State private var tasks: [Task] = [
        Task(name: "Buy groceries", isComplete: false),
        Task(name: "Walk dog", isComplete: false),
        Task(name: "Wash car", isComplete: true),
    ]
    @State private var newTask: String = ""
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(tasks.indices, id: \.self) {index in
                        HStack{
                            Button {
                                tasks[index].isComplete.toggle()
                            } label: {
                                Image(systemName: tasks[index].isComplete ? "circle.fill" : "circle")
                            }
                            .buttonStyle(.plain)
                            Text(tasks[index].name)
                                .strikethrough(tasks[index].isComplete, color: .gray)
                                .foregroundStyle(tasks[index].isComplete ? Color.secondary : .red)
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Task Manager")
                
                HStack{
                    TextField("New Task", text: $newTask)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        addTask()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel(Text("Add Task"))
                    .disabled(newTask.isEmpty)
                }
                .padding()
            }
        }
        .padding()
    }
    
    func deleteTask(_ indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func addTask() {
        if newTask.isEmpty { return }
        
        let taskToAdd: Task = Task(name: newTask, isComplete: false)
        tasks.append(taskToAdd)
        newTask = ""
    }
}

#Preview {
    ContentView()
}
