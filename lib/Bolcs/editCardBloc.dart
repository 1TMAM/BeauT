import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EditCardBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final number = BehaviorSubject<String>();
  final id = BehaviorSubject<int>();
  final cvv = BehaviorSubject<String>();
  final holder_name = BehaviorSubject<String>();
  final expData = BehaviorSubject<String>();

  Function(int) get updateId => id.sink.add;

  Function(String) get updateNumber => number.sink.add;

  Function(String) get updateCvv => cvv.sink.add;

  Function(String) get updateName => holder_name.sink.add;

  Function(String) get updateDate => expData.sink.add;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await CardsRepo.EditCard(
          id: id.value,
          number: number.value,
          date: expData.value,
          holder_name: holder_name.value,
          cvv: cvv.value);
      print("AddCard  Response" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }
}

final editCardBloc = EditCardBloc();
