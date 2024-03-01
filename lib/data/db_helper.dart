import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:fl_booking_app/data/booking_data.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If _database is null, initialize it
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the path to the database file
    String path = join(await getDatabasesPath(), 'bookings.db');

    // Open or create the database at the specified path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Create the Bookings table
        await db.execute('''
          CREATE TABLE Bookings(
            date TEXT,
            time TEXT,
            salonName TEXT, 
            salonId INTEGER, 
            priceTotal REAL, 
            clientName TEXT, 
            clientPhone TEXT, 
            clientComment TEXT, 
            personalPermit INTEGER
          )
        ''');
      },
    );
  }

  Future<void> insertBooking(BookingData booking) async {
    final Database db = await database;

    await db.insert(
      'Bookings',
      booking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<BookingData>> getBookings() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Bookings');

    List<BookingData> bookings = List.generate(maps.length, (i) {
      return BookingData(
        date: maps[i]['date'],
        time: maps[i]['time'],
        salonName: maps[i]['salonName'],
        salonId: maps[i]['salonId'],
        // services: maps[i]['services'],
        priceTotal: maps[i]['priceTotal'],
        clientName: maps[i]['clientName'],
        clientPhone: maps[i]['clientPhone'],
        clientComment: maps[i]['clientComment'],
        personalPermit: maps[i]['personalPermit'] == 0 ? false : true,
      );
    });

    for (BookingData booking in bookings) {
      // ignore: avoid_print
      print('Booking date: ${booking.date}, ClientPhone: ${booking.clientPhone}, clientName: ${booking.clientName}');
    }

    return bookings;
  }

  Future<void> updateBooking(BookingData booking) async {
    final Database db = await database;

    await db.update(
      'Bookings',
      booking.toMap(),
      where: 'clientPhone = ? AND date = ? AND time = ?',
      whereArgs: [booking.clientPhone, booking.date, booking.time],
    );
  }

  Future<void> deleteBooking(BookingData booking) async {
    final Database db = await database;

    await db.delete(
      'Bookings',
      where: 'clientPhone = ? AND date = ? AND time = ?',
      whereArgs: [booking.clientPhone, booking.date, booking.time],
    );
  }
}
