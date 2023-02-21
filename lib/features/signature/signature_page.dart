import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_morty_flutter/features/signature/signature_view_model.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignatureViewModel(),
        )
      ],
      child: const SignatureView(),
    );
  }
}

class SignatureView extends StatefulWidget {
  const SignatureView({Key? key}) : super(key: key);

  @override
  State<SignatureView> createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  late SignatureViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<SignatureViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: SfSignaturePad(
              key: viewModel.signaturePadKey,
              minimumStrokeWidth: 1,
              maximumStrokeWidth: 3,
              strokeColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: viewModel.saveSignature,
            child: const Text('Save signature'),
          ),
          FilledButton(
            onPressed: viewModel.clearSignaturePad,
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
