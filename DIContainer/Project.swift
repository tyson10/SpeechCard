//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 1/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "DIContainer",
    products: [
        .staticLibrary
    ],
    dependencies: [
        .Project.Core.data,
        .Project.Feature.shelf,
        .Project.Feature.edit,
        .Project.Feature.practice,
        .Project.Feature.challenge
    ]
)
