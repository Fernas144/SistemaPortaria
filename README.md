# crud_exemplo_1

Exemplo de implementação de cadastro de Pessoas, contendo listagem e inserção.
Complete a implementação por meio dos seguintes exercícios.


## Exercícios

1- Implemente a funcionalidade para alterar um registro de pessoa. Você pode incluir um botão de editar no `Card` utilizado para exibir os registros de pessoa em `pessoas_lista.dart`. Alternativamente, você pode implementar uma ação para abrir o registro de pessoa para alteração quando o usuário tocar no card. O form em `pessoa_form.dart` pode ser reutilizado.

2- Substitua o `TextFormField` do campo departamento por um [DropdownButton](https://api.flutter.dev/flutter/material/DropdownButton-class.html) ou [DropdownMenu](https://api.flutter.dev/flutter/material/DropdownMenu-class.html). Esse campo deve exibir uma lista fixa de departamentos. Exemplos: Financeiro, Contábil, TI, Vendas, etc.

3- Implementar a funcionalidade para excluir um registro de pessoa. Similar ao primeiro exercício, mas focado em remover um registro de pessoa. Abra um diálogo de confirmação antes de excluir definitivamente. Desafio: crie uma notificação por meio de um [snackbar](https://docs.flutter.dev/cookbook/design/snackbars) para avisar que o registro foi excluído com sucesso. Ofereça a opção de desfazer a exclusão.

4- Implemente um cadastro de produtos com os seguintes campos: nome, descrição, valor unitário e categoria.

5- Implemente um cadastro de categorias para produtos. Cada categoria deve apresentar os seguintes campos: nome, descrição e cor. A cor selecionada para a categoria deve ser utilizada ao exibir os produtos na tela de listagem de produtos.

6- Implemente persistência em banco de dados local. Para isso, utilize [SQlite](https://docs.flutter.dev/cookbook/persistence/sqlite) ou [Hive](https://pub.dev/packages/hive). O SQlite não funciona em todas as plataformas, mas é o mais utilizado para Android e iOS.

7- Implemente uma funcionalidade para tirar fotos tanto no cadastro de pessoas quanto no cadastro de produtos.

8- Substitua a persistência em banco de dados local pela persistência em uma API REST.

9- Implemente controle de usuários com autenticação e autorização.

10- Crie um layout personalizado para o seu aplicativo, alterando os temas e layouts originais.

11- Desafios:
- Resolva o problema de transição, quando troca da tela de pessoas para produtos, por exemplo. A transição faz parecer que uma tela nova está sendo criada. Ao invés disso, queremos que o usuário veja a transição como se fosse uma troca de abas na mesma tela.
- Teste e implemente formas diferentes de exibir o menu de cadastros (e.g., barra lateral).
- Mude o cadastro de pessoas para que apenas o nome e o email sejam obrigatórios.
