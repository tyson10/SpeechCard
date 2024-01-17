//
//  TargetDependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Taeyoung Son on 2023/07/15.
//

import ProjectDescription

extension TargetDependency {
    public struct Project {
        public struct Core { }
        public struct CommonUI { }
        public struct Feature { }
        public struct DIContainer { }
    }
    
    public struct ThirdParty { }
}

// MARK: - Core
public extension TargetDependency.Project.Core {
    static var extensions: TargetDependency {
        .project(
            target: "Extensions",
            path: .relativeToRoot("Core/Extensions")
        )
    }
    
    static var domain: TargetDependency {
        .project(
            target: "Domain",
            path: .relativeToRoot("Core/Domain")
        )
    }
    
    static var data: TargetDependency {
        .project(
            target: "Data",
            path: .relativeToRoot("Core/Data")
        )
    }
}

// MARK: - CommonUI
public extension TargetDependency.Project.CommonUI {
    static var ui: TargetDependency {
        .project(
            target: "CommonUI",
            path: .relativeToRoot("CommonUI")
        )
    }
}

// MARK: - Feature
public extension TargetDependency.Project.Feature {
    static var shelf: TargetDependency {
        .project(
            target: "Shelf",
            path: .relativeToRoot("Feature/Shelf")
        )
    }
    
    static var edit: TargetDependency {
        .project(
            target: "Edit",
            path: .relativeToRoot("Feature/Edit")
        )
    }
    
    static var practice: TargetDependency {
        .project(
            target: "Practice",
            path: .relativeToRoot("Feature/Practice")
        )
    }
    
    static var challenge: TargetDependency {
        .project(
            target: "Challenge",
            path: .relativeToRoot("Feature/Challenge")
        )
    }
}

// MARK: - DIContainer
public extension TargetDependency.Project.DIContainer {
    static var container: TargetDependency {
        .project(
            target: "DIContainer",
            path: .relativeToRoot("DIContainer")
        )
    }
}

// MARK: - Third Party
public extension TargetDependency.ThirdParty {
    static var composableArchitecture: TargetDependency {
        .external(name: "ComposableArchitecture")
    }
    
    static var lottie: TargetDependency {
        .external(name: "Lottie")
    }
}
