import 'package:flutter/material.dart';
import 'package:mynotes/services/crud/notes_service.dart';
import 'package:mynotes/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(DatabaseNote note);

class NotesListView extends StatelessWidget {
  final List<DatabaseNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback onTap;

  const NotesListView({
    super.key,
    required this.notes,
    required this.onDeleteNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(12.5, 0, 12.5, 0),
          //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Card(
            color: Color.fromARGB(255, 244, 249, 255),
            shadowColor: Color.fromARGB(255, 122, 192, 250),
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 10,
                end: 0,
                top: 15,
                bottom: 15,
              ),
              child: ListTile(
                onTap: () {
                  onTap(note);
                },
                title: Text(
                  note.text,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final shouldDelete = await showDeleteDialog(context);
                    if (shouldDelete) {
                      onDeleteNote(note);
                    }
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
