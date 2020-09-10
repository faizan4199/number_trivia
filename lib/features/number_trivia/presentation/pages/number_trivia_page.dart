import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_numbers/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:random_numbers/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:random_numbers/features/number_trivia/presentation/widgets/widgets.dart';
import 'package:random_numbers/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: BlocProvider(
        builder: (_) => sl<NumberTriviaBloc>(),
        child: SingleChildScrollView(child: buildBody(context)),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'noob',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
