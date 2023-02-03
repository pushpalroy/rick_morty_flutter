import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:data/injection.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDataInjection(String env) {
  GetIt.instance.$initGetIt(environment: env);
}
