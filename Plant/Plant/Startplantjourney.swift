//
//  Start plant journey .swift
//  Plant
//
//  Created by Noura  on 19/04/1446 AH.
//

import SwiftUI

struct Start_plant_journey_: View {
    @State private var plants: [Plant] = []
    @State private var showReminderForm = false
    @State private var selectedPlant: Plant?
    @State private var isFirstTime = true
    
    
    var body: some View {
        
        VStack {
            
            VStack {
                Text("My Plants 🌱")
                    .font(.system(size: 34,weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Divider()
                    .background(Color.white)
                
                
            }
            
            
            if plants.isEmpty{
                if isFirstTime{
                    VStack(spacing :20){
                        Image("PlantImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 164, height: 200)
                        
                        
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.lightGrey)
                            .padding(.horizontal,40)// Here we give space to the right and left because it is horizontal.
                        
                        Button(action: {
                            showReminderForm = true
                            isFirstTime = false
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 14, weight: .medium))
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color.color)
                                .foregroundColor(.blak1)
                                .cornerRadius(10)
                                .padding(.horizontal, 60)
                        }
                        
                    }
                    .padding(.top, 50)
                }else{
                    VStack(spacing:20){
                        Image("PlantImag2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 164, height: 200)
                        
                        Text("All Done! 🎉")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        
                        
                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.lightGrey)
                            .padding(.horizontal,40)
                        
                        
                        
                    }
                    
                }
                
            }else{
                // عرض قائمة النباتات
                List {
                    ForEach(sortedPlants()) { plant in
                        PlantRow(plant: plant, toggleWatered: toggleWatered)
                            .contentShape(Rectangle()) // لجعل العنصر كله قابل للنقر
                            .onTapGesture {
                                selectedPlant = plant
                                showReminderForm = true
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deletePlant(plant)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                }
            }
            
            Spacer()
            //هذي لازم اشوف وضعها انها تطلع بعدين مو بالبدايه
            //زر لإضافة تذكير جديد
        }
        Button(action: {
            showReminderForm = true
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.lightGrey)
                Text("New Reminder")
                    .foregroundColor(.lightGrey)
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showReminderForm) {
            PlantData(plants: $plants, plantToEdit: selectedPlant)
            
                .onDisappear {
                    selectedPlant = nil
                    
                }
        }
    }
    private func sortedPlants() -> [Plant] {
        return plants.sorted { !$0.checked && $1.checked }
    }
    
    // تغيير حالة الري
    private func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].checked.toggle()
            plants = sortedPlants() // تحديث القائمة
        }
    }
    
    // حذف النبات من القائمة
    private func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
    
    struct PlantRow: View {
        var plant: Plant
        var toggleWatered: (Plant) -> Void
        
        var body: some View {
            HStack {
                Button(action: {
                    toggleWatered(plant)
                }) {
                    Image(systemName: plant.checked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(plant.checked ? .lightGrey : .gray)
                }
                
                VStack(alignment: .leading) {
                    Text("\(plant.Room)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(plant.Name)
                        .font(.headline)
                    
                    HStack {
                        Label("Full sun", systemImage: "sun.max")
                            .font(.system(size: 14, weight: .light))
                            .padding(3)
                            .foregroundColor(Color.yellow)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        
                        Label("20-50 ml", systemImage: "drop")
                            .font(.system(size: 14, weight: .light))
                            .padding(3)
                            .foregroundColor(Color.blue)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
                // Divider (if needed)
            }
        }
        
        
    }
    
    
    
    #Preview {
        Start_plant_journey_()
    }
}
