-- upgrade --
CREATE TABLE IF NOT EXISTS "asset" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "added" TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP /* When this asset was added to the index. */,
    "modified" TIMESTAMP NOT NULL  DEFAULT CURRENT_TIMESTAMP /* When this record was last modified. */,
    "asset_type" VARCHAR(10) NOT NULL  /* The type of asset this is. */,
    "path" TEXT NOT NULL  /* Full path to the file. */,
    "filename" VARCHAR(250) NOT NULL  /* Name of the file. */,
    "digest" VARCHAR(32) NOT NULL  /* MD5 digest of the file */,
    "title" VARCHAR(250)   /* Title of the piece if applicable. */,
    "artist" VARCHAR(250)   /* Artist to credit for this piece as they should be listed. */,
    "credit_link" TEXT   /* URL to include in credits, if any. */,
    "license_link" TEXT   /* URL to license to include in credits, if any. */,
    "credit_required" INT NOT NULL  DEFAULT 1 /* Should this be credited in shownotes? */,
    "explicit_credit_required" INT NOT NULL  DEFAULT 1 /* Explicitly credited, or can it be summarized? */,
    "notes" TEXT   /* Your notes on this piece, if any. */,
    "bpm" INT   /* Beats per minute. Only calculated for music types. */
) /* Database model for a given audio asset. */;
CREATE TABLE IF NOT EXISTS "tag" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "tag_name" VARCHAR(50) NOT NULL  /* Display value of the tag. */,
    "tag_slug" VARCHAR(75)   /* Slug representation of the tag. */
) /* A tag that can be applied to an asset. */;
CREATE TABLE IF NOT EXISTS "aerich" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "version" VARCHAR(255) NOT NULL,
    "app" VARCHAR(100) NOT NULL,
    "content" JSON NOT NULL
);
CREATE TABLE IF NOT EXISTS "asset_tag" (
    "asset_id" INT NOT NULL REFERENCES "asset" ("id") ON DELETE CASCADE,
    "tag_id" INT NOT NULL REFERENCES "tag" ("id") ON DELETE CASCADE
) /* Tags applied to this asset. */;
