/// 接口，规范
abstract class HoldFacade {
  Future<bool> put(String key, dynamic value);

  dynamic get(String key);

  Future<bool> deleteAll();

  Future<bool> delete(String key);

  bool isContains(String key);
}
