import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.create(name: "SpeechCardApp",
                             products: [.app, .unitTests, .uiTests],
                             dependencies: [])
