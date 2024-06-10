//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 11/11/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "Data",
    products: [.staticLibrary],
    dependencies: [
        .Project.Core.domain,
        .Project.Core.extensions
    ]
)
