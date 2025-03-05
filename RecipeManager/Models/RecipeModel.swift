//
//  RecipeModel.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 03/09/24.
//

import Foundation

struct RecipeModel: Identifiable, Hashable, Equatable {
    static func == (lhs: RecipeModel, rhs: RecipeModel) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String
    var name: String
    var ingredients: [IngredientModel]
    var steps: [String]
    var tags: [TagModel]
    var notes: String
    var imageName: String
    var timeToPrep: Int?
    
    init(id: String = UUID().uuidString,
         name: String = "",
         ingredients: [IngredientModel] = [],
         steps: [String] = [],
         tags: [TagModel] = [],
         notes: String = "", 
         imageName: String = "",
         timeToPrep: Int? = nil) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.steps = steps
        self.tags = tags
        self.notes = notes
        self.imageName = imageName
        self.timeToPrep = timeToPrep
    }
}


struct RecipesMockData {
    static func getData() -> [RecipeModel] {
        let steps: [String] = [
            "Gently heat the milk and salt in a medium saucepan over a low heat for about 10 mins, stirring often, until it reaches 93°C on a sugar thermometer. Alternatively, watch the mixture carefully: the milk should be consistently foaming and steaming but should not begin to boil and bubble, as this will scald it and affect the flavour.",
            "Remove from the heat and stir in the lemon juice; the mixture should begin to look grainy. Cover the pan and set aside for 10 mins – curds of ricotta and a milky ‘whey’ should form. Line a sieve or colander with muslin and set over a bowl. Use a slotted spoon to carefully spoon the curds into the sieve; set aside for 45 mins to drain off any excess whey.",
            "The ricotta can now be eaten, plain or flavoured, or covered and chilled for up to 48 hrs. To flavour the cheese, try gently stirring through one of the combinations above. The 3 savoury ideas work well spread on hot toast and topped with sliced tomatoes, while the sweet option is lovely with fresh fruit and honey. Find more inspiration for using fresh ricotta here.",
            "To make the marmalade, halve 1kg Seville oranges and squeeze the juice into a large pan (it can help to do this through a sieve to catch any pips). Scoop out the remaining flesh and pips from the orange halves on to a muslin cloth (along with any pips caught in the sieve) and tie with string to make a bag, then set aside. You should now be left with just the orange peel. Cut into thin strips and add to the pan of orange juice along with the juice of 1 lemon.",
            "After the 2 hrs, remove the muslin bag and put in a small bowl. When cool, squeeze out all liquid from the bag back into the pan, along with any juices that have collected in the bowl. Add 2kg golden granulated sugar to the pan and simmer over a very low heat, stirring occasionally, for 15 mins, or until the sugar has dissolved."
        ]
        let ingredients: [IngredientModel] = IngredientsMockData.getData()
        let tags: [TagModel] = TagsMockData.getData()
        let notes: String = "These are the notes of the user that are supposed to mention something whatever the user desires to place here will be shown in this whole paragraph but right now im just writing a placeholder to visualize it in my preview i love swiftui."
        
        let data: [RecipeModel] = [
            .init(name: "delicious cookies", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "rissota lemon pie", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "Apple pie", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "Strawberry flavored cake", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "My favorite recipe", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "Thanksgiving smoked turkey", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150),
            .init(name: "Christmas cookies", ingredients: ingredients, steps: steps, tags: tags, notes: notes, imageName: "testingImage", timeToPrep: 150)
        ]
        
        return data
    }
    
}
