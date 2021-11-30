//
//  EmergencyCareUnitView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import SwiftUI
import Combine

struct EmergencyCareUnitView: View {

    @State var image: String
    @State var name: String
    @State var address: String
//    @State var distance: String

    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 8) {
                AsyncImage(withURL: image)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity, maxHeight: 150)
                VStack(spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "cross.fill")
                            .foregroundColor(.primary)
                            .frame(width: 12, height: 12)
                        Text(name)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 10) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.primary)
                            .frame(width: 12, height: 12)
                        Text(address)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }.frame(maxWidth: .infinity, alignment: .leading)
//                    HStack(spacing: 10) {
//                        Image(systemName: "clock")
//                            .foregroundColor(.primary)
//                            .frame(width: 12, height: 12)
//                        Text(distance)
//                            .font(.caption)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button(action: {
                            let scheme = "http"
                            let host = "maps.apple.com"
                            let path = "/?"
                            let queryItem = URLQueryItem(name: "address", value: address)

                            var urlComponents = URLComponents()
                            urlComponents.scheme = scheme
                            urlComponents.host = host
                            urlComponents.path = path
                            urlComponents.queryItems = [queryItem]

                            guard let url = urlComponents.url  else { return }
                            print(url.absoluteString)
                            UIApplication.shared.open(url)
                        }) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }.padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 28, trailing: 5))
    }
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct AsyncImage: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image: UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
            Image(uiImage: image)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}
