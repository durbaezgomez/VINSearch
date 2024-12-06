//
//  VehicleInfoView.swift
//  VINLookup
//
//  Created by Dominik Urbaez Gomez on 06/12/2024.
//

import SwiftUI

struct VehicleInfoView: View {
    let info: VehicleInfo
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "car.fill")
                .font(.system(size: 30))
                .foregroundStyle(.tint)
            
            VStack(spacing: 12) {
                InfoRow(label: "VIN", value: info.vin)
                
                Divider()
                
                InfoRow(label: "Manufacturer", value: info.manufacturerValue)
                    .opacity(info.manufacturer.map(info.isPremiumField) == true ? 0.6 : 1)
                InfoRow(label: "Model", value: info.modelValue)
                    .opacity(info.model.map(info.isPremiumField) == true ? 0.6 : 1)
                InfoRow(label: "Class", value: info.vehicleClassValue)
                    .opacity(info.vehicleClass.map(info.isPremiumField) == true ? 0.6 : 1)
                
                Divider()
                
                InfoRow(label: "Country", value: info.country)
                InfoRow(label: "Region", value: info.region)
                InfoRow(label: "WMI", value: info.wmi)
                InfoRow(label: "VDS", value: info.vds)
                InfoRow(label: "VIS", value: info.vis)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
        .padding()
    }
}

private struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .bold()
        }
    }
}

#Preview {
    let vehicleInfo1 = VehicleInfo(
        vin: "JH4KA7561PC008269",
        country: "Japan",
        manufacturer: "Acura",
        model: "Legend",
        vehicleClass: "Sedan/Saloon",
        region: "Asia",
        wmi: "JH4",
        vds: "KA7561",
        vis: "PC008269",
        year: 1993
    )
    
    let vehicleInfo2 = VehicleInfo(
        vin: "JH4KA7561PC008269",
        country: "Japan",
        manufacturer: "Only available for premium subscribers.",
        model: "Only available for premium subscribers.",
        vehicleClass: "Only available for premium subscribers.",
        region: "Asia",
        wmi: "JH4",
        vds: "KA7561",
        vis: "PC008269",
        year: 1993
    )
    
    ScrollView {
        VStack(spacing: 20) {
            VehicleInfoView(info: vehicleInfo1)
            VehicleInfoView(info: vehicleInfo2)
        }
    }
}