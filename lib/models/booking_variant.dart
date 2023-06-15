class BookingVariant {
  int bookingVariantId;
  int duration;

  BookingVariant({required this.bookingVariantId, required this.duration});

  factory BookingVariant.fromJson(Map<String, dynamic> json) {
    print(int.parse(json['bookingVariantId'].toString()));
    return BookingVariant(
      bookingVariantId: int.parse(json['bookingVariantId'].toString()),
      duration: int.parse(json['duration'].toString()),
    );
  }
}
