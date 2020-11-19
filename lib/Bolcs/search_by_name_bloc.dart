import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchByNameBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final name = BehaviorSubject<String>();

  Function(String) get updateName => name.sink.add;

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield Loading(null);
      ress = await UserJourny.SearchByName(name.value);
      print("Status " + ress.status.toString() + "");

      if (ress.status == true) {
        yield Done(ress);
      } else if (ress.status == false) {
        print("Message   ");
        yield ErrorLoading(ress);
      }
    }
  }
}

final searchByNameBloc = SearchByNameBloc();
