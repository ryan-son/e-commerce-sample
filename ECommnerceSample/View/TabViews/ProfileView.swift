//
//  ProfileView.swift
//  ECommnerceSample
//
//  Created by Geonhee on 2022/06/20.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          Text("My Profile")
            .font(.system(size: 28))
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)

          VStack(spacing: 15) {
            Image("ryan-son-profile")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 60, height: 60)
              .clipShape(Circle())
              .offset(y: -30)
              .padding(.bottom, -30)

            Text("Ryan Son")
              .font(.system(size: 16))
              .fontWeight(.semibold)

            HStack(alignment: .top, spacing: 10) {
              Image(systemName: "location.north.circle.fill")
                .foregroundColor(.gray)
                .rotationEffect(.init(degrees: 180))

              Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                .font(.system(size: 15))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          .padding([.horizontal, .bottom])
          .background(
            Color.white
              .cornerRadius(12)
          )
          .padding()
          .padding(.top, 40)
          
          customNavigationLink(title: "Edit Profile") {
            Text("")
              .navigationTitle("Edit Profile")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color(uiColor: .systemGray5).ignoresSafeArea())
          }

          customNavigationLink(title: "Shopping Address") {
            Text("")
              .navigationTitle("Shopping Address")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color(uiColor: .systemGray5).ignoresSafeArea())
          }

          customNavigationLink(title: "Order History") {
            Text("")
              .navigationTitle("Order History")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color(uiColor: .systemGray5).ignoresSafeArea())
          }

          customNavigationLink(title: "Cards") {
            Text("")
              .navigationTitle("Cards")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color(uiColor: .systemGray5).ignoresSafeArea())
          }

          customNavigationLink(title: "Notifications") {
            Text("")
              .navigationTitle("Notifications")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .background(Color(uiColor: .systemGray5).ignoresSafeArea())
          }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 20)
      }
      .navigationBarHidden(true)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        Color(uiColor: .systemGray5)
          .ignoresSafeArea()
      )
    }
  }
  
  @ViewBuilder
  func customNavigationLink<Detail: View>(
    title: String,
    @ViewBuilder content: @escaping () -> Detail
  ) -> some View {
    NavigationLink(destination: content) {
      HStack {
        Text(title)
          .font(.system(size: 17))
          .fontWeight(.semibold)

        Spacer()
        Image(systemName: "chevron.right")
      }
      .foregroundColor(.black)
      .padding()
      .background(
        Color.white
          .cornerRadius(12)
      )
      .padding(.horizontal)
      .padding(.top, 10)
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
