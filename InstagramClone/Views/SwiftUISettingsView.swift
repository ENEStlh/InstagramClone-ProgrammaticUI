//
//  SwiftUISettingsView.swift
//  InstagramClone
//
//  Created by ENES TALHA KIR on 23.02.2026.
//
import Foundation
import SwiftUI
import Firebase
import FirebaseAuth

struct SwiftUISettingsView: View {
    var onSignOutTapped: () -> Void = { }
    var body: some View {
        NavigationStack {
            ZStack {
               
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.blue.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(spacing: 32) {
                   
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .padding(.top, 40)
                    
                    Text("\(Auth.auth().currentUser?.email    ?? "Kullanıcı Adı")")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                   
                    VStack(spacing: 16) {
                        HStack {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(.blue)
                            Text("Hesap Ayarları")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(12)
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(.orange)
                            Text("Bildirimler")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    Spacer()
                   
                    Button(action: onSignOutTapped) {
                        HStack {
                            Image(systemName: "figure.walk.suitcase.rolling")
                            Text("Çıkış Yap")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("Ayarlar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SwiftUISettingsView()
}
