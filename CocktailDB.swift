//
//  Cocktail.swift
//  Just2Drink
//
//  Created by Alexander Kovzhut on 09.01.2022.
//
   
//https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a

struct CocktailDB: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let strDrink: String
    let strAlcoholic: String
    let strCategory: String
    let strDrinkThumb: String
    let strGlass: String
    let strInstructions: String
}
