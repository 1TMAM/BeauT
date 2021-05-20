import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProvicersBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      print("provider 11");
      ress = await UserJourny.GETALLPROVIDERS();
      print("Status " + ress.status.toString() + "");
      print("provider 22");
      yield Done(ress);
    }
  }
}

final allProvicersBloc = AllProvicersBloc();
