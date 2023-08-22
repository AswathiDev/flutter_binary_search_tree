import 'package:bst_evaluation_task/features/bstBloc/bloc/bst_bloc.dart';
import 'package:bst_evaluation_task/features/log/arrow_painter.dart';
import 'package:bst_evaluation_task/features/log/tree_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bst_evaluation_task/features/helper/navigation_helper.dart';

class BstScreen extends StatefulWidget {
  const BstScreen({super.key});

  @override
  State<BstScreen> createState() => _BstScreenState();
}

class _BstScreenState extends State<BstScreen> {
  final TextEditingController _inputController = TextEditingController();

  late final BstBloc _bstBloc = BlocProvider.of<BstBloc>(context);

  @override
  void initState() {
    super.initState();
    //  SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);
  }

  void _addToTree() {
    final enteredInput = int.parse(_inputController.text);
    final inputVaidator = enteredInput < 0;

    if (_inputController.text.trim().isEmpty || inputVaidator) {
//show error

      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('Please make sure a valid number is entered'),
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
        title: const Text(
          'Binary Search Tree',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],

              decoration: const InputDecoration(labelText: 'Enter a value'),
            ),
          ),
          const SizedBox(
            height: 20,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'Add to Tree',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BlocBuilder<BstBloc, BstState>(
            builder: (context, state) {
              if (state is BstNewValueAddedState) {
                return  buildTreeWidget(state.root);
              }
              return const Text('Loading...');
            },
          ),
        ],
      ),
    );
  }
}
double calculateLineHeight(TreeNode? childNode) {
  if (childNode == null || childNode.value == null) {
    return 0.0;
  }
  // Calculate the height of the child node by traversing the tree
  int height = calculateNodeHeight(childNode);
  
  // Calculate a dynamic line height based on the height of the child node
  // You can adjust the multiplier to control the line height
  return 20.0 + (height * 10.0); // Example calculation
}

int calculateNodeHeight(TreeNode? node) {
  if (node == null || node.value == null) {
    return 0;
  }
  // Recursively calculate the height of the node by comparing the height of its children
 int leftHeight = calculateNodeHeight(node.left);
  int rightHeight = calculateNodeHeight(node.right);
  return 1 + (leftHeight > rightHeight ? leftHeight : rightHeight);}

Widget buildTreeWidget(TreeNode? node) {
  if (node == null || node.value == null) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
    );
  }
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0.0, end: 1.0),
    duration: const Duration(milliseconds: 500), // Animation duration
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: 
        SingleChildScrollView( 
          child:
          //  Container(margin:const EdgeInsets.all(2),height: 160,
          //    child: 
              Column(
                children: [
                  Container(
                    height: 35,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the radius as needed
                      color: Colors.blue, // Set the background color
                    ),
                    child: Text(
                      node.value.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  // const  SizedBox(height: 20,),
                        //               
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //  buildTreeWidget(node.left),
                      // const  SizedBox(width: 20), //
                      //  buildTreeWidget(node.right),
                        
                      if (node.left != null)
                        Column(
                          children: [
                            // buildArrow(isLeftArrow: true),
                           Transform.rotate(
                  angle: 0.30, // Rotate line towards the left
                  child:   Container(
                       width: 2, // Line width
                       height: 40, // Line height
                       color: Colors.black,
                       margin: const EdgeInsets.symmetric(horizontal: 15),
                     )),
                            buildTreeWidget(node.left),
                          ],
                        ),
                      const SizedBox(width: 10),
                      if (node.right != null)
                        Column(
                          children: [
                            // buildArrow(isLeftArrow: false),
                          Transform.rotate(
                  angle: -0.30, // Rotate line towards the left
                  child:    Container(
                       width: 2, // Line width
                       height: 40, // Line height
                       color: Colors.black,
                       margin: const EdgeInsets.symmetric(horizontal: 15),
                     )),
                            buildTreeWidget(node.right),
                          ],
                        ),
                    ],
                  ),
                ],
                       ),
            
          //  ),
        ),
      );
    },
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
