//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 2023/07/08.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "Extensions",
    products: [
        .dynamicLibrary
    ],
    dependencies: []
)
