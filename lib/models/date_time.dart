class MockDateTime {
  final String date;
  final List<String> times;

  MockDateTime(this.date, this.times);
}

class OfficeDate {
  int officeId;
  String date;

  OfficeDate({required this.officeId, required this.date});

  factory OfficeDate.fromJson(Map<String, dynamic> json) {
    return OfficeDate(
      officeId: int.parse(json['officeId'].toString()),
      date: json['date'] as String,
    );
  }
}
