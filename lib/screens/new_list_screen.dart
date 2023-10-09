import 'package:flutter/material.dart';
import 'package:shopmate/services/auth/auth_service.dart';
import 'package:shopmate/services/cloud/cloud_lists.dart';
import 'package:shopmate/services/cloud/cloud_storage.dart';
import 'package:shopmate/utilities/generics/get_argument.dart';

class CreateUpdateListScreen extends StatefulWidget {
  const CreateUpdateListScreen({super.key});

  @override
  State<CreateUpdateListScreen> createState() => _CreateUpdateListScreenState();
}

class _CreateUpdateListScreenState extends State<CreateUpdateListScreen> {
  CloudList? _list;
  late final FirebaseCloudStorage _listsService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _listsService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListener() async {
    final list = _list;
    if (list == null) {
      return;
    }
    final text = _textController.text;
    _listsService.updateList(documentId: list.documentId, text: text);
  }

  void _setupTextControllerListener() {
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  Future<CloudList> createOrGetExistingList(BuildContext context) async {
    final widgetList = context.getArgument<CloudList>();

    if (widgetList != null) {
      _list = widgetList;
      _textController.text = widgetList.text;
      return widgetList;
    }

    final existingList = _list;
    if (existingList != null) {
      return existingList;
    } else {
      final currentUser = AuthService.firebase().currentUser!;
      final userId = currentUser.id;
      final newlist = await _listsService.createNewList(ownerUserId: userId);
      _list = newlist;
      return newlist;
    }
  }

  void _deleteListIfTextIsEmpty() {
    final list = _list;
    if (_textController.text.isEmpty && list != null) {
      _listsService.deleteList(documentId: list.documentId);
    }
  }

  void _saveListIfTextIsNotEmpty() {
    final list = _list;
    final text = _textController.text;
    if (text.isNotEmpty && list != null) {
      _listsService.updateList(documentId: list.documentId, text: text);
    }
  }

  @override
  void dispose() {
    _deleteListIfTextIsEmpty();
    _saveListIfTextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          'New List',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white54,
        bottomOpacity: 0.0,
      ),
      body: FutureBuilder(
        future: createOrGetExistingList(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Type list...',
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
