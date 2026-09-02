from importlib import metadata


def test_distribution_metadata_is_installed() -> None:
    assert metadata.version("urirun-runtime")


def test_runtime_namespace_is_provided_by_dependency() -> None:
    import urirun_runtime

    assert urirun_runtime.__name__ == "urirun_runtime"
