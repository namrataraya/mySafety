import 'package:my_safety/providers/user_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider.value(value: UserAuthProvider())
];
