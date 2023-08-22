import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bst_evaluation_task/features/log/tree_node.dart';
import 'package:flutter/widgets.dart';

part 'bst_event.dart';
part 'bst_state.dart';


class BstBloc extends Bloc<BstEvent, BstState> {
  // late TreeNode root;
    final  TreeNode _rootInstance; // Singleton instance of TreeNode

  // BstBloc() : root = TreeNode(null), super(BstNewValueAddedState(TreeNode(null))){
  BstBloc() : _rootInstance = TreeNode.getInstance(), super(BstNewValueAddedState(TreeNode.getInstance())) {

 on<AddValueEvent>(addValueEvent);//event handling
  }

  FutureOr<void> addValueEvent(AddValueEvent event, Emitter<BstState> emit) {
   

      _rootInstance.insert(event.value);
      emit(BstNewValueAddedState(_rootInstance));
    
  }
}