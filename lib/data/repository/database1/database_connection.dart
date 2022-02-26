import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  Future<MySqlConnection> openConnection() async {
    var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'viacep',
    );
    return await MySqlConnection.connect(settings);
  }
}
