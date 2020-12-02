//
//  MissionView.swift
//  Moonshot
//
//  Created by Denny Mathew on 02/12/20.
//

import SwiftUI
struct MissionDetailView: View {
    let mission: Mission
    let width: CGFloat
    var body: some View {
        VStack {
            Image(self.mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: width * 0.7)
                .padding(.top)
            Text(self.mission.description)
                .padding()
            Spacer(minLength: 25)
        }
    }
}
struct CrewMembersView: View {
    let crew: [CrewMember]
    var body: some View {
        VStack {
            ForEach(self.crew, id: \.role) { member in
                HStack {
                    Image(member.astronaut.id)
                        .resizable()
                        .frame(width: 83, height: 60)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                    VStack(alignment: .leading) {
                        Text(member.astronaut.name)
                            .font(.headline)
                        Text(member.role)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}
struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                MissionDetailView(mission: mission, width: geometry.size.width)
                CrewMembersView(crew: astronauts)
            }
        }
        .navigationBarTitle(mission.displayName, displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member) in astronauts list.")
            }
        }
        self.astronauts = matches
    }
}
struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
