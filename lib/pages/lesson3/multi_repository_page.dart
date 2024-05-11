import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo23/repository/first_repository.dart';
import 'package:ngdemo23/repository/second_repository.dart';
import '../../bloc/repository_second_bloc.dart';

class MultiRepositoryPage extends StatefulWidget {
  const MultiRepositoryPage({super.key});

  @override
  State<MultiRepositoryPage> createState() => _MultiRepositoryPageState();
}

class _MultiRepositoryPageState extends State<MultiRepositoryPage> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FirstRepository(),
        ),
        RepositoryProvider(
          create: (context) => SecondRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            RepositorySecondBloc(
                context.read<FirstRepository>(),
                context.read<SecondRepository>()),
        child: SamplePage(),
      ),
    );
  }
}
class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Multi Repository Provider"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<RepositorySecondBloc,int>(
              builder:  (context,state)=>Text(
                state.toString(),
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(width: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                    color:Colors.blue ,
                    textColor: Colors.white,
                    onPressed: (){
                      context
                      .read<RepositorySecondBloc>()
                          .add(RepositoryFirstMultiEvent());
                    },
                  child: Text("first")),
                  SizedBox(width: 15,),
                MaterialButton(
                  color:Colors.blue ,
                  textColor: Colors.white,
                  onPressed: (){
                    context
                        .read<RepositorySecondBloc>()
                        .add(RepositorySecondMultiEvent());
                  },
                  child: Text("second"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

