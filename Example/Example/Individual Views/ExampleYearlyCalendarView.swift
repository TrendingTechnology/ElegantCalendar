// Kevin Li - 4:49 PM - 6/14/20

import SwiftUI

struct ExampleYearlyCalendarView: View {

    @ObservedObject private var calendarManager: ElegantCalendarManager

    let visitsByDay: [Date: [Visit]]

    init(ascVisits: [Visit]) {
        let configuration = CalendarConfiguration(calendar: currentCalendar,
                                                  startDate: ascVisits.first!.arrivalDate,
                                                  endDate: ascVisits.last!.arrivalDate,
                                                  themeColor: .blackPearl)
        calendarManager = ElegantCalendarManager(configuration: configuration,
                                                 initialMonth: .daysFromToday(365))
        visitsByDay = Dictionary(grouping: ascVisits, by: { currentCalendar.startOfDay(for: $0.arrivalDate) })
    }

    var body: some View {
        YearlyCalendarView(calendarManager: calendarManager.yearlyManager)
    }

}

struct ExampleYearlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleYearlyCalendarView(ascVisits: Visit.mocks(start: .daysFromToday(-365*2), end: .daysFromToday(365*2)))
    }
}
