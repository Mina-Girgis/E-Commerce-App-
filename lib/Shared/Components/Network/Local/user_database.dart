import 'package:e_commerce/Models/usermodel.dart';
import 'package:sqflite/sqflite.dart';

class UsersDatabase {
  // price double , image string , name string

  static late Database database;
  static List<User> userData = [];
  static List<User> Users=[];
  static Future<void> createDatabase() async {
    database = await openDatabase('users.db', version: 1,
        onCreate: (database, version) {
      print("User Database is created !!");
      database
          .execute(
              'CREATE TABLE users (id INTEGER PRIMARY KEY, name text, mail text , phoneNumber text ,password text ,address text)')
          .then((value) {
        print('User TABLE IS CREATED !!');
      }).catchError((error) {
        print(error.toString());
      });
    }, onOpen: (database) {
      print('User Database is open !!');
      getData(database);
    });
  }

  static Future<void> getData(Database database) async {
    userData.clear();
    await database.rawQuery('SELECT * FROM users').then((value) {
      value.forEach((element) {
        userData.add(User(
            name: element['name'] as String,
            id: element['id'].toString() as String,
            mail: element['mail'] as String,
            phoneNumber: element['phoneNumber'] as String,
            address: element['address'] as String,
            password: element['password'] as String));
      });
      print('From users getData function Length is : ${userData.length}');
    }).catchError((error) {
      print(error.toString());
    });
  }


  // static Future<void> getUserById(Database database , int id) async {
  //
  //   await database.rawQuery('SELECT * FROM users where id = ? ',[id]).then((value) {
  //     value.forEach((element) {
  //       user = User(
  //           name: element['name'] as String,
  //           id: element['id'].toString() as String,
  //           mail: element['mail'] as String,
  //           phoneNumber: element['phoneNumber'] as String,
  //           address: element['address'] as String,
  //           password: element['password'] as String);
  //     });
  //     // print(user.name);
  //     // print('From users getData function Length is : ${userData.length}');
  //   }).catchError((error) {
  //     print(error.toString());
  //   });
  // }

  static Future<void> insertDatabase(
      {required String name,
      required String address,
      required String email,
      required String password,
      required String phoneNumber}) async {
    await database.rawInsert(
        'INSERT INTO users (name,address, mail ,phoneNumber ,password) VALUES ( ?,?,?,?,? )',
        [name, address, email, phoneNumber, password]).then((value) {
      print(" userDatabase Record $value is inserted !!");
      getData(database);
    }).catchError((error) {
      print(error.toString());
    });
  }





  static void updateDatabase(
      {required String name,
      required String phone,
      required String email,
      required String password,
      required int id}) async {
    await database.rawUpdate(
        'update users set name = ? , phoneNumber = ?, mail = ? ,password = ? where id = ?',
        [name, phone, email, password, id]).then((value) {
      print(value);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void deleteDatabase(int id) async {
    await database
        .rawDelete('DELETE FROM users WHERE id = ?', [id]).then((value) {
      print(value);
    }).catchError((error) {
      print(error.toString());
    });
  }

  static void deleteAllData() {
    for (int i = 1; i <= userData.length; i++) {
      deleteDatabase(i);
    }
    userData.clear();
  }

  // login
  static User validData({required String password, required String mail}) {
    // validData for login screen
    User user = new User();
    int valid = -1;
    List.generate(userData.length, (index) {
      if (userData[index].password == password &&
          userData[index].mail == mail) {
        print("good");
        user.id = userData[index].id;
        user.mail = userData[index].mail;
        user.name = userData[index].name;
        user.phoneNumber = userData[index].phoneNumber;
        user.password = userData[index].password;
        user.mail = userData[index].mail;
        user.address = userData[index].address;
        valid = int.parse(userData[index].id);
      }
    });
    if (valid == -1) {
      user.id = -1;
    }
    return user;
  }

  //register
  static bool isFoundInDatabase({required String name, required String mail}) {
    int count = 0;
    List.generate(userData.length, (index) {
      if (userData[index].mail == mail && userData[index].name == name) {
        count++;
      }
    });
    if (count == 0)
      return false;
    else
      return true;
  }
}
