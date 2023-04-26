//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Augusto Simionato on 23/01/23.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                VStack {
                    Text("Participantes")
                        .font(.headline)
                    Text(history.attendeeString)
                        .padding(.bottom)
                    if let transcript = history.transcript {
                        Text("Transcrição")
                            .font(.headline)
                            .padding()
                        Text(transcript)
                            .padding()
                    }
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
    }
}

extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [DailyScrum.Attendee(name: "Jon"), DailyScrum.Attendee(name: "Darla"), DailyScrum.Attendee(name: "Luis")], lengthInMinutes: 10, transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI...")
    }
    
    static var previews: some View {
        HistoryView(history: history)
    }
}
