TORTOISE_ORM = {
    "connections": {
        "default": "sqlite://assets.db",
    },
    "apps": {
        "models": {
            "models": [
                "audprodassetdb.models",
                "aerich.models",
            ],
            "default_connection": "default",
        },
    },
}
