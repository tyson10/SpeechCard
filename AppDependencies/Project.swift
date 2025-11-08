//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 9/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(
    name: "AppDependencies",
    products: [
        .framework
    ],
    dependencies: [
        .Project.Core.data,
        .Project.Utility.utility,
        .Project.CommonUI.ui,
        .ThirdParty.composableArchitecture
    ]
)
