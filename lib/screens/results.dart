import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_application/controllers/api_controller.dart';
import 'package:flutter_clean_architecture_application/screens/components/entry_card.dart';
import 'package:flutter_clean_architecture_application/utils/const/categories.dart';

class Results extends StatelessWidget {
  Results({super.key, required this.category});
  final String category; // adicionamos a categoria

  final ApiController apiController =
      ApiController(); // instanciamos o ApiController

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(categories[category]!),
          actions: [
            IconButton( // icone para salvar
                onPressed: () {},
                icon: const Icon(Icons.bookmark)) 
          ],
        ),
        body: FutureBuilder( // adicionamos um FutureBuilder para exibir os resultados
          future: apiController.getEntriesByCategory( // chamamos o método getEntriesByCategory do ApiController
              category:
                  category), 
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;

              case ConnectionState.none:
                break;

              case ConnectionState.done:
                if (snapshot.hasData) { // se tiver dados, exibimos os resultados
                  return ListView.builder( // usamos um ListView.builder para exibir os resultados
                    itemBuilder: (context, index) => EntryCard( // componente EntryCard para exibir cada resultado
                      entry: snapshot.data![index],
                      isSaved: false,
                    ),
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return Center(
                    child: Text("Results: ${snapshot.error}"),
                  );
                }

              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
