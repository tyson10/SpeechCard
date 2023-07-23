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
    }
    
    public struct ThirdParty { }
}

// MARK: - Core
public extension TargetDependency.Project.Core {
    static var extensions: TargetDependency {
        .project(target: "Extensions", path: .relativeToRoot("Core/Extensions"))
    }
    
    static var model: TargetDependency {
        .project(target: "Model", path: .relativeToRoot("Core/Model"))
    }
}

// MARK: - CommonUI
public extension TargetDependency.Project.CommonUI {
    static var ui: TargetDependency {
        .project(target: "CommonUI", path: .relativeToRoot("CommonUI"))
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
