# Pokedex

This is an iOS implementeation of a Pokedex made using SwiftUI.

This app uses the [PokeAPI](https://pokeapi.co/) to make asynchronous requests to gather Pokemon information. Once the information is received, it is then stored in a SQLite database (using GRDB) to prevent duplicate requests from being made.

This app features two views. The first is the Pokomon List which consists of a cell that shows each Pokemon's name, image, national dex number, and type(s). Tapping on a pokemon's cell will show a detailed view, which also displays a pokedex entry, stats (HP, attack, defense, etc.), type mastchups (imunities, weaknesses, resistances) and physical characteristics (height and weight). In additino, thisb app aleso features the ability to search for Pokemon by name from the list view.

# Neat things I would like to add in the future

* The ability to favorite Pokemon and add them to a list
* The ability to make a team of 6 pokemon and analyze it for weak points (bad type matchups)
* Different sprites for detail view
* Ability to view shiny sprites in detail page
* Ability to see all moves a Pokemon can learn
* Improving the process of loading Pokemon info from the API
