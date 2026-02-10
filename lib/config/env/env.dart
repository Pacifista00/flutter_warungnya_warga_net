import 'dev_env.dart';
import 'prod_env.dart';

class Env {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static String get baseUrl => isProduction ? ProdEnv.baseUrl : DevEnv.baseUrl;

  static String get midtransClientKey =>
      isProduction ? ProdEnv.midtransClientKey : DevEnv.midtransClientKey;
}
