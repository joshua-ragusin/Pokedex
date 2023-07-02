# Pokedex

This is an iOS implementeation of a Pokedex made using SwiftUI.

This app uses the [PokeAPI](https://pokeapi.co/) to make asynchronous requests to gather Pokemon information. Once the information is received, it is then stored in a SQLite database (using GRDB) to prevent duplicate requests from being made.

This app features two views. The first is the Pokomon List which consists of a cell that shows each Pokemon's name, image, national dex number, and type(s). Tapping on a pokemon's cell will show a detailed view, which also displays a pokedex entry, stats (HP, attack, defense, etc.), type mastchups (imunities, weaknesses, resistances) and physical characteristics (height and weight). In additino, thisb app aleso features the ability to search for Pokemon by name from the list view.

# Screenshots

iPad:

![Simulator Screenshot - iPad Air (5th generation) - 2023-07-02 at 15 27 09](https://github.com/joshua-ragusin/Pokedex/assets/130528752/ae6315ad-9233-4942-ba02-e782460bd870)
![Simulator Screenshot - iPad Air (5th generation) - 2023-07-02 at 15 27 15](https://github.com/joshua-ragusin/Pokedex/assets/130528752/b9569199-7cbd-427d-8939-c9ea6bd3665c)


iPhone:

![Simulator Screenshot - iPhone 14 Pro - 2023-07-02 at 15 30 53](https://github.com/joshua-ragusin/Pokedex/assets/130528752/3325361c-d904-446c-bf3a-e828fc430d99)
![Simulator Screenshot - iPhone 14 Pro - 2023-07-02 at 15 31 01](https://github.com/joshua-ragusin/Pokedex/assets/130528752/678cb512-2066-4bdd-8b01-9e4202622504)


# Demo

![gif1](https://github.com/joshua-ragusin/Pokedex/assets/130528752/8a1100ee-ee3f-46cd-a39d-545547c605d5)
![gif2](https://github.com/joshua-ragusin/Pokedex/assets/130528752/376365b1-8cf1-40b6-9ec9-009fc3fc769e)



# Neat things I would like to add in the future

* The ability to favorite Pokemon and add them to a list
* The ability to make a team of 6 pokemon and analyze it for weak points (bad type matchups)
* Different sprites for detail view
* View all forms of a pokemon from detail view
* Ability to view shiny sprites in detail page
* Ability to see all moves a Pokemon can learn
* Improving the process of loading Pokemon info from the API
* Unit tests for store methods
