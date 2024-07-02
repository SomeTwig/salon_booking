import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:fl_booking_app/data/booking_data.dart';
import 'package:fl_booking_app/models/models.dart';

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
          CREATE TABLE Booking(
            bookingId INTEGER PRIMARY KEY,
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
        await db.execute('''
          CREATE TABLE BookingService(
            serviceId INTEGER,
            bookingId INTEGER,
            serviceParamId INTEGER,
            serviceName TEXT,
            serviceParam TEXT, 
            lineOfBusinessId INTEGER, 
            lineOfBusiness TEXT, 
            hasParam INTEGER, 
            price REAL, 
            discountedPrice REAL, 
            discountedPercent INTEGER,
            duration INTEGER,
            quantity INTEGER,
            FOREIGN KEY (bookingId) REFERENCES Booking (bookingId)
          )
        ''');
        await db.execute('''
          CREATE TABLE MyAccount(
            accountName TEXT,
            accountPhone TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertAccount(MyAccount account) async {
    final Database db = await database;

    await db.insert(
      'MyAccount',
      account.toMap(),
    );
  }

  Future<List<Map>> getAccount(String accountPhone) async {
    final Database db = await database;

    print(accountPhone);
    List<Map> map = await db.query(
      'MyAccount',
      where: 'accountPhone = ?',
      whereArgs: [accountPhone],
    );

    return map;
  }

  Future<void> getAllAccountPhones() async {
    final Database db = await database;

    List<Map> map = await db.query('MyAccount', columns: ['accountPhone']);

    print(map.toString());
  }

  Future<void> insertBooking(BookingData booking) async {
    final Database db = await database;

    final insertedId = await db.insert(
      'Booking',
      booking.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // ignore: avoid_print
    print('insertedId: $insertedId');

    Batch batch = db.batch();
    for (var service in booking.services) {
      batch.insert('BookingService', service.toMap(insertedId));
    }
    batch.commit(noResult: true);
  }

  Future<List<BookingData>> getAllBookings() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Booking');

    List<BookingData> bookings = List.generate(maps.length, (i) {
      return BookingData(
        date: maps[i]['date'],
        time: maps[i]['time'],
        salonName: maps[i]['salonName'],
        salonId: maps[i]['salonId'],
        services: [],
        priceTotal: maps[i]['priceTotal'],
        clientName: maps[i]['clientName'],
        clientPhone: maps[i]['clientPhone'],
        clientComment: maps[i]['clientComment'],
        personalPermit: maps[i]['personalPermit'] == 0 ? false : true,
      );
    });

    for (BookingData booking in bookings) {
      // ignore: avoid_print
      print(
          'Booking date: ${booking.date}, ClientPhone: ${booking.clientPhone}, clientName: ${booking.clientName}');
    }

    return bookings;
  }

  Future<List<FLService>> getAllBookingServices() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('BookingService');

    List<FLService> bookingServices = List.generate(maps.length, (i) {
      return FLService(
        serviceId: maps[i]['serviceId'],
        serviceParamId: maps[i]['serviceParamId'],
        serviceName: maps[i]['serviceName'],
        serviceParam: maps[i]['serviceParam'],
        lineOfBusinessId: maps[i]['lineOfBusinessId'],
        lineOfBusiness: maps[i]['lineOfBusiness'],
        hasParam: maps[i]['hasParam'] == 0 ? false : true,
        price: maps[i]['price'],
        discountedPrice: maps[i]['discountedPrice'],
        discountedPercent: maps[i]['discountedPercent'],
        duration: maps[i]['duration'],
        quantity: maps[i]['quantity'],
      );
    });

    for (FLService bookingService in bookingServices) {
      // ignore: avoid_print
      print(
          'serviceName: ${bookingService.serviceName}, price: ${bookingService.price}, quantity: ${bookingService.quantity}');
    }

    return bookingServices;
  }

  Future<void> updateBooking(BookingData booking) async {
    final Database db = await database;

    await db.update(
      'Booking',
      booking.toMap(),
      where: 'clientPhone = ? AND date = ? AND time = ?',
      whereArgs: [booking.clientPhone, booking.date, booking.time],
    );
  }

  Future<void> deleteBooking(BookingData booking) async {
    final Database db = await database;

    await db.delete(
      'Booking',
      where: 'clientPhone = ? AND date = ? AND time = ?',
      whereArgs: [booking.clientPhone, booking.date, booking.time],
    );
  }

  Future<List<FLService>> getOneBookingServices(
      String date, String time, String clientPhone, String salonId) async {
    final Database db = await database;

    List<Map> bMaps = await db.query('Booking',
        columns: ['bookingId'],
        where: 'date = ? AND time = ? AND clientPhone = ? AND salonId = ?',
        whereArgs: [date, time, clientPhone, salonId]);

    final List<Map<String, dynamic>> maps =
        await db.query('BookingService', where: 'bookingId = ?', whereArgs: [
      bMaps.first['bookingId'],
    ]);

    List<FLService> services = List.generate(maps.length, (i) {
      return FLService(
        serviceId: maps[i]['serviceId'],
        serviceParamId: maps[i]['serviceParamId'],
        serviceName: maps[i]['serviceName'],
        serviceParam: maps[i]['serviceParam'],
        lineOfBusinessId: maps[i]['lineOfBusinessId'],
        lineOfBusiness: maps[i]['lineOfBusiness'],
        hasParam: maps[i]['hasParam'] == 0 ? false : true,
        price: maps[i]['price'],
        discountedPrice: maps[i]['discountedPrice'],
        discountedPercent: maps[i]['discountedPercent'],
        duration: maps[i]['duration'],
        quantity: maps[i]['quantity'],
      );
    });

    for (FLService service in services) {
      // ignore: avoid_print
      print('Service name: ${service.serviceName}');
    }

    return services;
  }

  Future<List<BookingData>> getAccountBookings(
      String accountName, String accountPhone) async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'Booking',
      where: 'clientName = ? AND clientPhone = ?',
      whereArgs: [accountName, accountPhone],
    );

    List<BookingData> bookings = List.generate(maps.length, (i) {
      return BookingData(
        date: maps[i]['date'],
        time: maps[i]['time'],
        salonName: maps[i]['salonName'],
        salonId: maps[i]['salonId'],
        services: [],
        priceTotal: maps[i]['priceTotal'],
        clientName: maps[i]['clientName'],
        clientPhone: maps[i]['clientPhone'],
        clientComment: maps[i]['clientComment'],
        personalPermit: maps[i]['personalPermit'] == 0 ? false : true,
      );
    });

    for (BookingData booking in bookings) {
      // ignore: avoid_print
      print(
          'Booking date: ${booking.date}, ClientPhone: ${booking.clientPhone}, clientName: ${booking.clientName}');
    }

    return bookings;
  }
}
