//
//  Workspace.swift
//  SpeechCardManifests
//
//  Created by Taeyoung Son on 2023/07/02.
//

import ProjectDescription

let workspace = Workspace(
    name: "SpeechCard",
    projects: [
        "SpeechCardApp/**",
        "CommonUI/**",
        "Core/Extensions/**",
        "Core/Model/**"
    ]
)
