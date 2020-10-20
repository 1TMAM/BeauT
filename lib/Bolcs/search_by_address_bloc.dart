import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchByAddressBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final address = BehaviorSubject<String>();

  Function(String) get updateAddress => address.sink.add;

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = await UserJourny.SEARCHBYADDRESS(address.value);
      print("Status " + ress.status.toString() + "");

      yield Done(ress);
    }
  }
}

final searchByAddressBloc = SearchByAddressBloc();
