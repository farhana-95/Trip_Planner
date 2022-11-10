import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';


class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  _DataSource _getDataSource(){
    final List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now().add(Duration(hours: 4)),
      endTime: DateTime.now().add(Duration(hours: 5)),
      subject: 'Meeting',
      color: Colors.red,
    ));
    return _DataSource(appointments);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event Calendar'),),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          allowedViews: [
            CalendarView.month,
            CalendarView.schedule
          ],
          dataSource: _getDataSource(),
          monthViewSettings: MonthViewSettings(showAgenda: true),
          appointmentTimeTextFormat: 'hh:mm:ss a',

      ),),
    );

  }
}
class _DataSource extends CalendarDataSource{
  _DataSource(List<Appointment> source){
    appointments = source;
  }
}
