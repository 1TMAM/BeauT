import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class GetBeauticianDetailsBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final id = BehaviorSubject<int>();

  Function(int) get updateId => id.sink.add;

  var ress;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Hydrate) {
      yield Loading(null);
      ress = await UserJourny.GetBeauticianDetails(id.value);
      print("Status " + ress.status.toString() + "");

      yield Done(ress);
    }
  }
}

final getBeauticianDetailsBloc = GetBeauticianDetailsBloc();
