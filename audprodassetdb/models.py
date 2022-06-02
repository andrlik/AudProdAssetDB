from enum import Enum

from tortoise import fields
from tortoise.models import Model


class AssetType(Enum):

    """Enum values for use in model choice fields."""

    SFX = "sfx"
    MUSIC = "music"
    PROMO = "promo"
    AD = "ad"


class Asset(Model):

    """Database model for a given audio asset."""

    added = fields.DatetimeField(
        auto_now_add=True, description="When this asset was added to the index."
    )
    modified = fields.DatetimeField(
        auto_now=True, description="When this record was last modified."
    )
    asset_type = fields.CharEnumField(
        enum_type=AssetType, max_length=10, description="The type of asset this is."
    )
    path = fields.TextField(description="Full path to the file.")
    filename = fields.CharField(max_length=250, description="Name of the file.")
    digest = fields.CharField(max_length=32, description="MD5 digest of the file")
    title = fields.CharField(
        max_length=250, null=True, description="Title of the piece if applicable."
    )
    artist = fields.CharField(
        max_length=250,
        null=True,
        description="Artist to credit for this piece as they should be listed.",
    )
    credit_link = fields.TextField(
        null=True, description="URL to include in credits, if any."
    )
    license_link = fields.TextField(
        null=True, description="URL to license to include in credits, if any."
    )
    credit_required = fields.BooleanField(
        default=True, description="Should this be credited in shownotes?"
    )
    explicit_credit_required = fields.BooleanField(
        default=True,
        description="Explicitly credited, or can it be summarized?",
    )
    notes = fields.TextField(null=True, description="Your notes on this piece, if any.")
    bpm = fields.IntField(
        null=True, description="Beats per minute. Only calculated for music types."
    )
    tags = fields.ManyToManyField(
        "models.Tag", description="Tags applied to this asset."
    )

    def __str__(self):  # pragma: nocover
        return f"{self.title} - {self.artist} ({self.filename})"


class Tag(Model):
    """
    A tag that can be applied to an asset.
    """

    tag_name = fields.CharField(max_length=50, description="Display value of the tag.")
    tag_slug = fields.CharField(
        max_length=75, null=True, description="Slug representation of the tag."
    )

    def __str__(self):  # pragma: nocover
        return self.tag_name
