import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CurrentOrdersBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final type = BehaviorSubject<String>();

  Function(String) get updateType => type.sink.add;
  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = type.value == "currernt"
          ? await UserJourny.GETCURRENTORDERS()
          : await UserJourny.GETDONEORDERS();
      print("Status " + ress.status.toString() + "");
      yield Done(ress);
    }
  }
}

final currentOrdersBloc = CurrentOrdersBloc();
