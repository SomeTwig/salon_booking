class BookingVariant {
  int bookingVariantId;
  String timeFrom;
  String timeTo;
  int duration;

  BookingVariant({required this.bookingVariantId, required this.timeFrom, required this.timeTo, required this.duration});

  factory BookingVariant.fromJson(Map<String, dynamic> json) {
    //print(int.parse(json['bookingVariantId'].toString()));
    return BookingVariant(
      bookingVariantId: int.parse(json['bookingVariantId'].toString()),
      timeFrom: json['timeFrom'] as String,
      timeTo: json['timeTo'] as String,
      duration: int.parse(json['duration'].toString()),
    );
  }
}
