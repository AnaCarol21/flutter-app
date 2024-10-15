class HourHelper{
  static int hoursToMinutes(String hours){
    List<String> parts = hours.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return hour * 60 + minute;
  }

  static String minutesToHours(int minutes){
    int hour = minutes ~/ 60;
    int minute = minutes % 60;
    return '${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}';
  }
}