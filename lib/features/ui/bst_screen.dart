import 'package:bst_evaluation_task/features/bloc/bloc/bst_bloc.dart';
import 'package:bst_evaluation_task/features/log/arrow_painter.dart';
import 'package:bst_evaluation_task/features/log/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bst_evaluation_task/features/helper/navigation_helper.dart';

class BstScreen extends StatefulWidget {
  const BstScreen({super.key});

  @override
  State<BstScreen> createState() => _BstScreenState();
}

class _BstScreenState extends State<BstScreen> with TickerProviderStateMixin{
    final TextEditingController _inputController = TextEditingController();

  late final BstBloc _bstBloc = BlocProvider.of<BstBloc>(context);

@override
  void initState() {
    super.initState();
  }

void _addToTree(){
      final enteredInput = int.parse(_inputController.text);
          final inputVaidator = enteredInput < 0;

if (_inputController.text.trim().isEmpty||inputVaidator) {
//show error

      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid number is entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        NavigationHelper.navigatePop(context);
                      },
                      child: const Text('Ok'))
                ],
              ));
      return;
    }
     _bstBloc.add(AddValueEvent(enteredInput));
                
         _inputController.clear();

}

  @override
  Widget build(BuildContext context) {


   return Scaffold(
      appBar: AppBar(
        title: const Text('Binary Search Tree'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
            decoration:const InputDecoration(labelText: 'Enter a value'),
          ),
          ElevatedButton(
            onPressed: () {
              // final int value = int.parse(_inputController.text);
              // if (value != null) {
              //   _bstBloc.add(AddValueEvent(value));
                
              //   _inputController.clear();
              // }
              _addToTree();
            },
            child:const Text('Add to Tree'),
          ),
          BlocBuilder<BstBloc, BstState>(
            builder: (context, state) {
              if (state is BSTLoadedState) {
                return Expanded(child: buildTreeWidget(state.root));
              }
              return  const Text('Loading...');
            },
          ),
        ],
      ),
    );
  }
}
 Widget buildTreeWidget(TreeNode? node) {
  if (node == null || node.value == null) {
    return Container(decoration: const BoxDecoration(color: Colors.white),);
  }
  return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500), // Animation duration
      builder: (context, value, child) {
        return Opacity(
      opacity: value,
      child: SingleChildScrollView(
        child: Column(
            children: [
              Container(padding:const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                color: Colors.blue, // Set the background color
              ),child: Text(node.value.toString(),style: const TextStyle(color: Colors.white),),),
            // const  SizedBox(height: 20,),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                      //  buildTreeWidget(node.left),
                      // const  SizedBox(width: 20), //
                      //  buildTreeWidget(node.right),
    
                        if (node.left != null)
                Column(
                  children: [
                   buildArrow(isLeftArrow: true),
                    buildTreeWidget(node.left),
                  ],
                ),
              const SizedBox(width: 20),
              if (node.right != null)
                Column(
                  children: [
                    buildArrow(isLeftArrow: false),
                    buildTreeWidget(node.right),
                  ],
                ),
                   
                  ],
                ),
              
            ],
          
        ),
      ),
    );},
  );
}
Widget buildArrow({required bool isLeftArrow}) {
  return SizedBox(
    width: 8,
    height: 20,
    child: CustomPaint(
      painter: ArrowPainter(isLeftArrow: isLeftArrow),
    ),
  );
}