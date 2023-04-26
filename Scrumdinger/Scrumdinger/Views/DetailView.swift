/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("Informações da Reunião")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Começar Reunião", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Duração", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutos")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Tema", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Participantes")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person.fill")
                }
            }
            Section(header: Text("Histórico")) {
                if scrum.history.isEmpty {
                    Label("Sem reunião ainda", systemImage: "calendar")
                }
                ForEach(scrum.history) { history in
                    NavigationLink(destination: HistoryView(history: history)) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Editar") {
                isPresentingEditView = true
                data = scrum.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Voltar") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("OK") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
