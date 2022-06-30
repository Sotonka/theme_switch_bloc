import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../hive/theme_hive.dart';

class ThemeDatabaseService {
//Create a global Singleton out of this class. All fields and methods used
//in this class should be static to be accessible globally.
  ThemeDatabaseService._();
//This is the field variable for the Hive database
  static var themeBox;
//This method is used to check if the database exists
  static Future<void> checkDatabaseExists() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();
//Initialise the database
    Hive.init(themeDatabaseDir.path);
//If the database exists, open it. Else, call the createDatabase method
    if (await Hive.boxExists('themeBox')) {
      themeBox = await Hive.openBox('themeBox');
    } else {
      createDatabase();
    }
  }

//This method is used to create the database
  static Future<void> createDatabase() async {
    Directory themeDatabaseDir = await getApplicationSupportDirectory();
//Initialise the database
    Hive.init(themeDatabaseDir.path);
//Register the Hive database Type Adapter
    Hive.registerAdapter(ThemeDatabaseAdapter());
//Open the database
    themeBox = await Hive.openBox('themeBox');
//Objects in a Hive database are stored as a key-value pair
//by default - 0 - light theme

    await themeBox.put('themeSettings', 0);
  }

//This method is used to update the theme settings of the app.
  static putThemeSettings(int themeFlag) {
    themeBox.put('themeSettings', themeFlag);
  }

//This method return a Boolean and is used to get the value of the “themeSettings”
//key-value pair if the “themeBox” is not null. If it is null, then a default
//value of '0' is returned
  static int getThemeSettings() {
    int themeValue = themeBox?.get('themeSettings') ?? 0;
    return themeValue;
  }
}
