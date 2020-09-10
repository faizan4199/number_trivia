import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_numbers/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final controller = TextEditingController();
  String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter Number'),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                child: Text(
                  'Search',
                ),
                color: Colors.grey[800],
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
              child: RaisedButton(
                child: Text(
                  'Get Random Trivia',
                ),
                color: Colors.grey[200],
                textTheme: ButtonTextTheme.primary,
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .dispatch(GetTriviaForRandomNumber());
  }
}
