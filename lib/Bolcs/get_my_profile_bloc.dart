import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetMyProfileBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    print("InBlocc");
    if (event is Hydrate) {
      yield Start(null);
      ress = await UserDataRepo.GetProfileApi();
      print("InBlocc");

      yield Done(ress);
    }
  }
}

final getMyProfileBloc = GetMyProfileBloc();
