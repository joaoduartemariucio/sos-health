//
//  HistoryCardView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 29/11/21.
//

import SwiftUI
import MapKit
import Combine

struct AnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct HistoryCardView: View {

    @State var event: ModelRequestEmergency
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.898150, longitude: -77.034340),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.1)
    )

    @State var annotationItems: [AnnotationItem] = [AnnotationItem]()

    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 8) {
                Text(event.eventDesc)
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Map(coordinateRegion: $region, annotationItems: annotationItems) {
                    MapPin(coordinate: $0.coordinate)
                }
                .frame(maxWidth: .infinity, minHeight: 200)
                HStack {
                    Spacer()
                    Text("Data: \(event.date)")
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 5)
        .onAppear {
            region = .init(center: .init(latitude: event.eventLat, longitude: event.eventLong), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            annotationItems.append(.init(coordinate: .init(latitude: event.eventLat, longitude: event.eventLong)))
        }
    }
}
