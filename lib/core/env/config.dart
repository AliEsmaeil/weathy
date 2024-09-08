
import 'package:envied/envied.dart';

part 'config.g.dart';

@envied
final class Config{

  @EnviedField(obfuscate: true, varName: 'apiKey', )
  static final String  apiKey = _Config.apiKey;
}