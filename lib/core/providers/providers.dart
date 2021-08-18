 
import 'package:intelligent_inno_task/core/viewModel/userViewModel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final providers = <SingleChildWidget>[
  ChangeNotifierProvider(
    create: (context) => UsersViewModel(),
  )
];
