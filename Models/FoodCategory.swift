// FoodCategory.swift
import Foundation

enum FoodCategory: String, Codable, CaseIterable {
    case dairy = "Milchprodukte"
    case meat = "Fleisch"
    case vegetable = "Gemüse"
    case fruit = "Obst"
    case beverage = "Getränke"
    case condiment = "Gewürze/Saucen"
    case leftover = "Reste"
    case other = "Sonstiges"
}
