//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 11/11/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(name: "Edit",
                             products: [.staticFramework, .unitTests, .uiTests],
                             dependencies: [],
                             includeDemoApp: true)
