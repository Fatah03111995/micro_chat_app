import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(obfuscate: true, varName: 'BASE_ENDPOINT')
  static String baseEndpoint = _Env.baseEndpoint;
}
