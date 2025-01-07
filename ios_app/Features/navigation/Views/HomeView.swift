//
//  HomeView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct FindUHomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top Header
            HStack {
                Text("Find")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("primary"))
                Text("U")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundColor(Color("surface"))
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            // Swipable Card Component
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 400)
                    .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 8) {
                    // University Details
                    HStack {
                        Text("Average ACT: 25")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(6)
                            .background(Color.yellow.opacity(0.8))
                            .cornerRadius(8)
                        
                        Text("Public University")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(6)
                            .background(Color.green.opacity(0.8))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("Avg Aid: $16,278")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(6)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("Avg Tuition: $12,324")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(6)
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                    
                    Text("Student Size: 19,189")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(6)
                        .background(Color.red.opacity(0.2))
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("University of Nebraska-Lincoln")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Lincoln, NE")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Button(action: {
                            // Dislike action
                        }) {
                            Image(systemName: "xmark.circle")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Reset action
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Like action
                        }) {
                            Image(systemName: "heart.circle")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
            .padding(.horizontal)
            .padding(.top, 16)
            
            Spacer()
            
            // Bottom Navigation Bar
            HStack {
                VStack {
                    Image(systemName: "heart")
                        .font(.title)
                    Text("Saved")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
                
                VStack {
                    Image(systemName: "paintbrush")
                        .font(.title)
                    Text("Explore")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
                
                VStack {
                    Image(systemName: "gear")
                        .font(.title)
                    Text("Settings")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .shadow(radius: 5)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.white)
    }
}

struct FindUHomeView_Previews: PreviewProvider {
    static var previews: some View {
        FindUHomeView()
    }
}
