import 'package:flutter/material.dart';
import 'post_form.dart';

class FormRoute extends StatelessWidget {
  const FormRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: EntryForm()
    );
  }
}