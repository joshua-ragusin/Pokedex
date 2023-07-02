# Pokedex

This is an iOS implementeation of a Pokedex made using SwiftUI.

This app uses the [PokeAPI](https://pokeapi.co/) to make asynchronous requests to gather Pokemon information. Once the information is received, it is then stored in a SQLite database (using GRDB) to prevent duplicate requests from being made.

This app features two views. The first is the Pokomon List which consists of a cell that shows each Pokemon's name, image, national dex number, and type(s). Tapping on a pokemon's cell will show a detailed view, which also displays a pokedex entry, stats (HP, attack, defense, etc.), type mastchups (imunities, weaknesses, resistances) and physical characteristics (height and weight). In additino, thisb app aleso features the ability to search for Pokemon by name from the list view.

# Screenshots

iPad:

![Simulator Screenshot - iPad Air (5th generation) - 2023-07-02 at 15 27 09](https://github.com/joshua-ragusin/Pokedex/assets/130528752/f1e8ace4-7ad5-4ef5-a469-8af72297a3a3)
![Simulator Screenshot - iPad Air (5th generation) - 2023-07-02 at 15 27 15](https://github.com/joshua-ragusin/Pokedex/assets/130528752/b59164d4-8e5a-4ca0-9ce2-d28b2a621517)



iPhone:

![Simulator Screenshot - iPhone 14 Pro - 2023-07-02 at 15 30 53](https://github.com/joshua-ragusin/Pokedex/assets/130528752/3387e7f1-69ec-4e57-ab51-b8ad5a936eb7)
![Simulator Screenshot - iPhone 14 Pro - 2023-07-02 at 15 31 01](https://github.com/joshua-ragusin/Pokedex/assets/130528752/db9e0fac-e449-4ecc-9cef-82369e928fde)



# Demo

![gif1](https://github.com/joshua-ragusin/Pokedex/assets/130528752/8b435b22-ccbb-48b0-94c2-c42ef21929e8)
![gif2](https://github.com/joshua-ragusin/Pokedex/assets/130528752/6591ce36-1719-4b46-9958-a1dfce2819fb)


# Neat things I would like to implement/improve in the future

* The ability to favorite Pokemon and add them to a list
* The ability to make a team of 6 pokemon and analyze it for weak points (bad type matchups)
* Different sprites for detail view
* View all forms of a pokemon from detail view
* Ability to view shiny sprites in detail page
* Ability to see all moves a Pokemon can learn
* Improving the process of loading Pokemon info from the API
* Unit tests for store methods
