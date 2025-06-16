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
                color: AppColors.primaryColor.withOpacity(0.9), // Remplace deprecated_member_use
                padding: const EdgeInsets.all(8),
                child: TableCalendar(
                  focusedDay: controller.selectedDate.value,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => isSameDay(day, controller.selectedDate.value),
                  onDaySelected: (selectedDay, _) {
                    controller.selectDate(selectedDay); // Appel explicite à la méthode du contrôleur
                  },
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
                child: controller.coursSemaine.isEmpty
                    ? const Center(child: Text("Aucun cours pour cette semaine"))
                    : ListView.builder(
                        itemCount: controller.coursSemaine.length,
                        itemBuilder: (context, index) {
                          final cours = controller.coursSemaine[index];
                          // Parser les heures manuellement depuis les chaînes
                          final startParts = cours.heureDebut.split(':');
                          final endParts = cours.heureFin.split(':');
                          final startHour = int.parse(startParts[0]);
                          final startMinute = int.parse(startParts[1].split('.')[0]);
                          final endHour = int.parse(endParts[0]);
                          final endMinute = int.parse(endParts[1].split('.')[0]);
                          final isAM = startHour < 12;
                          final startTime = '$startHour:${startMinute.toString().padLeft(2, '0')} ${isAM ? 'AM' : 'PM'}';
                          final endTime = '$endHour:${endMinute.toString().padLeft(2, '0')} ${endHour < 12 ? 'AM' : 'PM'}';

                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: 4,
                            color: AppColors.primaryColor.withOpacity(0.2), // Remplace deprecated_member_use
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