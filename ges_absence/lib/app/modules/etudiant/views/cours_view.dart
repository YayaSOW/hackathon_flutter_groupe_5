import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/cours_controller.dart';
import 'package:ges_absence/theme/colors.dart';

class CoursView extends StatelessWidget {
  final controller = Get.put(CoursController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Cours"),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Obx(() => Column(
            children: [
              Container(
                // ignore: deprecated_member_use
                color: AppColors.primaryColor.withOpacity(0.9),
                padding: const EdgeInsets.all(8),
                child: TableCalendar(
                  focusedDay: controller.selectedDate.value,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => isSameDay(day, controller.selectedDate.value),
                  onDaySelected: (selectedDay, _) => controller.selectedDate.value = selectedDay,
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.secondaryColor.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: const TextStyle(color: Colors.white70),
                    defaultTextStyle: const TextStyle(color: Colors.white),
                    outsideTextStyle: const TextStyle(color: Colors.white30),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
                    leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.coursSemaine.length,
                  itemBuilder: (context, index) {
                    final cours = controller.coursSemaine[index];
                    // Formater les heures au format "HH:mm AM/PM"
                    final startTime = '${cours.heureDebut.hour}:${cours.heureDebut.minute.toString().padLeft(2, '0')} ${cours.heureDebut.period == DayPeriod.am ? 'AM' : 'PM'}';
                    final endTime = '${cours.heureFin.hour}:${cours.heureFin.minute.toString().padLeft(2, '0')} ${cours.heureFin.period == DayPeriod.am ? 'AM' : 'PM'}';
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      // ignore: deprecated_member_use
                      color: AppColors.primaryColor.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.book, color: AppColors.secondaryColor),
                        title: Text(
                          cours.nomCours,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          "${cours.date.day}/${cours.date.month}/${cours.date.year} • De $startTime à $endTime",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}