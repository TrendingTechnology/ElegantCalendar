// Kevin Li - 2:26 PM - 6/14/20

import ElegantPages
import SwiftUI

struct MonthlyCalendarView: View, MonthlyCalendarManagerDirectAccess {

    @ObservedObject var calendarManager: MonthlyCalendarManager

    private var isTodayWithinDateRange: Bool {
        Date() >= startDate && Date() <= endDate
    }

    private var isCurrentMonthYearSameAsTodayMonthYear: Bool {
        calendar.isDate(currentMonth, equalTo: Date(), toGranularities: [.month, .year])
    }

    var body: some View {
        ZStack(alignment: .top) {
            monthsList
                .zIndex(0)
            if isTodayWithinDateRange && !isCurrentMonthYearSameAsTodayMonthYear {
                leftAlignedScrollBackToTodayButton
                    .padding(.trailing, CalendarConstants.horizontalPadding)
                    .offset(y: CalendarConstants.Monthly.topPadding)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }

    private var monthsList: some View {
        ElegantVList(manager: calendarManager.pagerManager)
    }

    private var leftAlignedScrollBackToTodayButton: some View {
        HStack {
            Spacer()
            ScrollBackToTodayButton(scrollBackToToday: calendarManager.scrollBackToToday,
                                    color: themeColor)
        }
    }

}

struct MonthlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        LightDarkThemePreview {
            MonthlyCalendarView(calendarManager: .mock)

            MonthlyCalendarView(calendarManager: .mockWithInitialMonth)
        }
    }
}
