part of 'bst_bloc.dart';

@immutable
sealed class BstEvent {}

class AddValueEvent extends BstEvent {
  final int value;
  AddValueEvent(this.value);
}
