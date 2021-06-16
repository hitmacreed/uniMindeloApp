import 'package:get_storage/get_storage.dart';

final storage = GetStorage();
const String user_uid = 'user_uid';

void saveData(key, value) {
  storage.write(key, value);
}

getData(key) {
  return storage.read(key);
}


void deleteData(key) {
  storage.remove(key);
}
