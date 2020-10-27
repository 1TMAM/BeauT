import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchByTimeBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final time = BehaviorSubject<String>();

  Function(String) get updateId => time.sink.add;

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = await UserJourny.SEARCHBYTIME(time.value);
      print("Status " + ress.status.toString() + "");

      yield Done(ress);
    }
  }
}

final searchByTimeBloc = SearchByTimeBloc();
