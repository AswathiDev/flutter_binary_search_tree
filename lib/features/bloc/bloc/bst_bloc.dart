import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bst_evaluation_task/features/log/tree_node.dart';
import 'package:flutter/widgets.dart';

part 'bst_event.dart';
part 'bst_state.dart';


class BstBloc extends Bloc<BstEvent, BstState> {
  late TreeNode root;
  
  BstBloc() : root = TreeNode(null), super(BSTLoadedState(TreeNode(null))){
 on<AddValueEvent>(addValueEvent);
  }

  FutureOr<void> addValueEvent(AddValueEvent event, Emitter<BstState> emit) {
    // print(event.value);
    // if (event == AddValueEvent) {
          // print('is root${root.value}');

      root.insert(event.value);
      emit(BSTLoadedState(root));
    // }
  }
}