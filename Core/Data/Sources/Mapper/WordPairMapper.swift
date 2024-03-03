//
//  WordPairMapper.swift
//  Data
//
//  Created by Taeyoung Son on 3/3/24.
//

import Domain

extension WordPairType {
    var data: WordPairDTO {
        return WordPairDTO(
            origin: origin,
            target: target
        )
    }
}
