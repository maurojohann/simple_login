abstract class UserRepository {
  Future<bool> signinAuth(String user, String password);
}

class UserRepositoryLocal implements UserRepository {
  @override
  Future<bool> signinAuth(String user, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    return user == 'cooper' && password == 'card';
  }
}
