import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_flutter/features/episodes/episodes_view_model.dart';
import 'package:rick_morty_flutter/features/signature/signature_page.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EpisodesViewModel(),
        )
      ],
      child: const EpisodesView(),
    );
  }
}

class EpisodesView extends StatelessWidget {
  const EpisodesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SignaturePage(),
      ],
    );
  }
}
