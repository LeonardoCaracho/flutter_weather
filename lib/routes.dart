import 'package:equatable/equatable.dart';

class Routes extends Equatable {
  static const home = '/';

  static const search = 'search';

  static const settings = 'settings';

  @override
  List<Object?> get props => [home, search, settings];
}
