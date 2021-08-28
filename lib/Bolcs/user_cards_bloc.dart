import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCardsBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Start(null);
      ress = await CardsRepo.get_user_credit_cards();
      print("Status " + ress.status.toString() + "");
      yield Done(ress);
    }
  }
}

final usercards_bloc = UserCardsBloc();
