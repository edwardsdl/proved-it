//
//  ProofService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

final class ProofService {
    let proofApiClient: ProofApiClientType
    let coreDataStore: CoreDataStoreType

    init(withProofApiClient proofApiClient: ProofApiClientType, coreDataStore: CoreDataStoreType) {
        self.proofApiClient = proofApiClient
        self.coreDataStore = coreDataStore
    }
}
