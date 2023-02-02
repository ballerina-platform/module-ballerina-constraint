// Copyright (c) 2023 WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

type Album record {|
    string title;
    string artist;
|};

type ReadOnlyAlbum readonly & Album;

type ReadOnlyAlbumWithoutConstraints readonly & record {|
    string title;
    string artist;
|};

@test:Config {}
function testReadOnlyAlbumWithoutConstraints() {
    Album album = {title: "Blue Train", artist: "John Coltrane"};
    ReadOnlyAlbum|error validation1 = validate(album);
    if validation1 is error {
        test:assertFail("Unexpected error found.");
    }

    readonly & Album|error validation2 = validate(album);
    if validation2 is error {
        test:assertFail("Unexpected error found.");
    }

    do {
        readonly & Album album1 = check album.cloneWithType();
        album1 = check validate(album1);
    } on fail error err {
        test:assertFail("Unexpected error found.");
    }

    ReadOnlyAlbumWithoutConstraints|error validation3 = validate(album);
    if validation3 is error {
        test:assertFail("Unexpected error found.");
    }
}

type AlbumWithConstraint record {|
    @String {
        maxLength: 5,
        minLength: 1
    }
    string title;
    string artist;
|};

type ReadOnlyConstrainedAlbum readonly & AlbumWithConstraint;

type ReadOnlyAlbumWithConstraints readonly & record {|
    @String {
        maxLength: 5,
        minLength: 1
    }
    string title;
    string artist;
|};

@test:Config {}
function testReadOnlyAlbumWithConstraintsSuccess() {
    Album album = {title: "Jeru", artist: "Gerry Mulligan"};
    ReadOnlyConstrainedAlbum|error validation1 = validate(album);
    if validation1 is error {
        test:assertFail("Unexpected error found.");
    }

    readonly & AlbumWithConstraint|error validation2 = validate(album);
    if validation2 is error {
        test:assertFail("Unexpected error found.");
    }

    do {
        readonly & AlbumWithConstraint album1 = check album.cloneWithType();
        album1 = check validate(album1);
    } on fail {
        test:assertFail("Unexpected error found.");
    }

    ReadOnlyAlbumWithConstraints|error validation3 = validate(album);
    if validation3 is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testReadOnlyAlbumWithConstraintsFailure() {
    Album album = {title: "Blue Train", artist: "John Coltrane"};
    ReadOnlyConstrainedAlbum|error validation1 = validate(album);
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    readonly & AlbumWithConstraint|error validation2 = validate(album);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    do {
        readonly & AlbumWithConstraint album1 = check album.cloneWithType();
        album1 = check validate(album1);
        test:assertFail("Expected error not found.");
    } on fail error err {
        test:assertEquals(err.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    }

    ReadOnlyAlbumWithConstraints|error validation3 = validate(album);
    if validation3 is error {
        test:assertEquals(validation3.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type AlbumWithReadOnlyConstraints record {|
    @String {
        maxLength: 5,
        minLength: 1
    }
    readonly string title;
    string artist;
|};

@test:Config {}
function testAlbumWithReadOnlyConstraintsSuccess() {
    Album album = {title: "Jeru", artist: "Gerry Mulligan"};
    AlbumWithReadOnlyConstraints|error validation = validate(album);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testAlbumWithReadOnlyConstraintsFailure() {
    Album album = {title: "Blue Train", artist: "John Coltrane"};
    AlbumWithReadOnlyConstraints|error validation = validate(album);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    maxLength: 5,
    minLength: 1
}
type AlbumTitle string;

type ReadOnlyAlbumWithConstraintType readonly & record {|
    AlbumTitle title;
    string artist;
|};

@test:Config {}
function testReadOnlyAlbumWithConstraintTypeSuccess() {
    Album album = {title: "Jeru", artist: "Gerry Mulligan"};
    ReadOnlyAlbumWithConstraintType|error validation = validate(album);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testReadOnlyAlbumWithConstraintTypeFailure() {
    Album album = {title: "Blue Train", artist: "John Coltrane"};
    ReadOnlyAlbumWithConstraintType|error validation = validate(album);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@String {
    maxLength: 5,
    minLength: 1
}
type ReadOnlyAlbumTitle readonly & string;

type AlbumWithReadOnlyConstraintType record {|
    ReadOnlyAlbumTitle title;
    string artist;
|};

@test:Config {}
function testAlbumWithReadOnlyConstraintTypeSuccess() {
    Album album = {title: "Jeru", artist: "Gerry Mulligan"};
    AlbumWithReadOnlyConstraintType|error validation = validate(album);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testAlbumWithReadOnlyConstraintTypeFailure() {
    Album album = {title: "Blue Train", artist: "John Coltrane"};
    AlbumWithReadOnlyConstraintType|error validation = validate(album);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

@Int {
    minValue: 0,
    maxValue: 5
}
type Rating int;

type Artist record {|
    string name;
    Rating rating;
    ReadOnlyAlbumWithConstraints[] albums;
|};

@test:Config {}
function testArtistSuccess() {
    Artist artist = {
        name: "Gerry Mulligan",
        rating: 4,
        albums: [
            {title: "Jeru1", artist: "Gerry Mulligan"},
            {title: "Jeru2", artist: "Gerry Mulligan"}
        ]
    };
    Artist|error validation = validate(artist);
    if validation is error {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testArtistFailure() {
    Artist artist = {
        name: "John Coltrane",
        rating: 4,
        albums: [
            {title: "Train", artist: "John Coltrane"},
            {title: "Blue Train", artist: "John Coltrane"}
        ]
    };
    Artist|error validation = validate(artist);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.albums[1].title:maxLength' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}

type ReadOnlyArtist readonly & Artist;

@test:Config {}
function testReadOnlyArtistSuccess() {
    Artist artist = {
        name: "Gerry Mulligan",
        rating: 4,
        albums: [
            {title: "Jeru1", artist: "Gerry Mulligan"},
            {title: "Jeru2", artist: "Gerry Mulligan"}
        ]
    };
    ReadOnlyArtist|error validation1 = validate(artist);
    if validation1 is error {
        test:assertFail("Unexpected error found.");
    }

    readonly & Artist|error validation2 = validate(artist);
    if validation2 is error {
        test:assertFail("Unexpected error found.");
    }

    do {
        readonly & Artist artist1 = check artist.cloneWithType();
        artist1 = check validate(artist1);
    } on fail {
        test:assertFail("Unexpected error found.");
    }
}

@test:Config {}
function testReadOnlyArtistFailure1() {
    Artist artist = {
        name: "Gerry Mulligan",
        rating: 10,
        albums: [
            {title: "Jeru1", artist: "Gerry Mulligan"},
            {title: "Jeru2", artist: "Gerry Mulligan"}
        ]
    };
    ReadOnlyArtist|error validation1 = validate(artist);
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    readonly & Artist|error validation2 = validate(artist);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    do {
        readonly & Artist artist1 = check artist.cloneWithType();
        artist1 = check validate(artist1);
        test:assertFail("Expected error not found.");
    } on fail error err {
        test:assertEquals(err.message(), "Validation failed for '$.rating:maxValue' constraint(s).");
    }
}

@test:Config {}
function testReadOnlyArtistFailure2() {
    Artist artist = {
        name: "John Coltrane",
        rating: 10,
        albums: [
            {title: "Train", artist: "John Coltrane"},
            {title: "Blue Train", artist: "John Coltrane"}
        ]
    };
    ReadOnlyArtist|error validation1 = validate(artist);
    if validation1 is error {
        test:assertEquals(validation1.message(), "Validation failed for '$.albums[1].title:maxLength','$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    readonly & Artist|error validation2 = validate(artist);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$.albums[1].title:maxLength','$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }

    do {
        readonly & Artist artist1 = check artist.cloneWithType();
        artist1 = check validate(artist1);
        test:assertFail("Expected error not found.");
    } on fail error err {
        test:assertEquals(err.message(), "Validation failed for '$.albums[1].title:maxLength','$.rating:maxValue' constraint(s).");
    }
}
