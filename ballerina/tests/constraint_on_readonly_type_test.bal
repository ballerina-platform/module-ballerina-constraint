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

    ReadOnlyAlbumWithoutConstraints|error validation2 = validate(album);
    if validation2 is error {
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

    ReadOnlyAlbumWithConstraints|error validation2 = validate(album);
    if validation2 is error {
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

    ReadOnlyAlbumWithConstraints|error validation2 = validate(album);
    if validation2 is error {
        test:assertEquals(validation2.message(), "Validation failed for '$.title:maxLength' constraint(s).");
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
    ReadOnlyArtist|error validation = validate(artist);
    if validation is error {
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
    ReadOnlyArtist|error validation = validate(artist);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
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
    ReadOnlyArtist|error validation = validate(artist);
    if validation is error {
        test:assertEquals(validation.message(), "Validation failed for '$.albums[1].title:maxLength','$.rating:maxValue' constraint(s).");
    } else {
        test:assertFail("Expected error not found.");
    }
}
