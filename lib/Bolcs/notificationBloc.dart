import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = await UserDataRepo.GetNotifications();
      print("Status " + ress.status.toString() + "");
      yield Done(ress);
    }
  }
}

final notificationBloc = NotificationBloc();
