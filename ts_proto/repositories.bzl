"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("@bazel_tools//tools/build_defs/repo:git.bzl", _git_repository = "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def http_archive(name, **kwargs):
    maybe(_http_archive, name = name, **kwargs)

def git_repository(name, **kwargs):
    maybe(_git_repository, name = name, **kwargs)

def local_repository(name, **kwargs):
    maybe(native.local_repository, name = name, **kwargs)

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
# This is all fixed by bzlmod, so we just tolerate it for now.
def rules_ts_proto_dependencies():
    """Repositories required by rules_ts_proto."""

    # The minimal version of bazel_skylib we require
    http_archive(
        name = "bazel_skylib",
        sha256 = "f7be3474d42aae265405a592bb7da8e171919d74c16f082a5457840f06054728",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.2.1/bazel-skylib-1.2.1.tar.gz",
        ],
    )

    git_repository(
        name = "rules_proto_grpc",
        commit = "1c9e81538467d3809dbf4035007397138a015583",
        remote = "https://github.com/gonzojive/rules_proto_grpc.git",
    )

    # local_repository(
    #    name = "rules_proto_grpc",
    #    path = "/home/red/code/rules_proto_grpc",
    # )

    git_repository(
        name = "com_google_protobuf_javascript",
        commit = "1167b4e01dadb0e444e3837b23a812b2535ea9a0",
        remote = "https://github.com/gonzojive/protobuf-javascript.git",
    )

    # local_repository(
    #     name = "com_google_protobuf_javascript",
    #     path = "/home/red/code/protobuf-javascript",
    # )

    http_archive(
        name = "rules_proto",
        sha256 = "dc3fb206a2cb3441b485eb1e423165b231235a1ea9b031b4433cf7bc1fa460dd",
        strip_prefix = "rules_proto-5.3.0-21.7",
        urls = [
            "https://github.com/bazelbuild/rules_proto/archive/refs/tags/5.3.0-21.7.tar.gz",
        ],
    )

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "dd926a88a564a9246713a9c00b35315f54cbd46b31a26d5d8fb264c07045f05d",
        urls = [
            "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
            "https://github.com/bazelbuild/rules_go/releases/download/v0.38.1/rules_go-v0.38.1.zip",
        ],
    )

    http_archive(
        name = "aspect_bazel_lib",
        sha256 = "688354ee6beeba7194243d73eb0992b9a12e8edeeeec5b6544f4b531a3112237",
        strip_prefix = "bazel-lib-2.8.1",
        url = "https://github.com/aspect-build/bazel-lib/releases/download/v2.8.1/bazel-lib-v2.8.1.tar.gz",
    )

    http_archive(
        name = "aspect_rules_js",
        sha256 = "4cab6898f0ff8048e32640cce06a47aa4b92b2fb330d055940f95f24c8ebb868",
        strip_prefix = "rules_js-2.0.1",
        url = "https://github.com/aspect-build/rules_js/releases/download/v2.0.1/rules_js-v2.0.1.tar.gz",
    )

    # git_repository(
    #     name = "aspect_rules_js",
    #     commit = "fc9bd0cfc52d0cfbaf69538e6425094bb077afe9",
    #     remote = "https://github.com/gonzojive/rules_js.git",
    # )

    # Sometimes pushed to the reddaly-dev branch of
    # https://github.com/gonzojive/grpc-web.git
    # local_repository(
    #     name = "com_github_grpc_grpc_web",
    #     path = "/home/red/code/grpc-web",
    # )

    # https://github.com/aspect-build/rules_ts/releases/tag/v1.2.0
    http_archive(
        name = "aspect_rules_ts",
        sha256 = "f69a6452b129d39d9b05f3dff8b1057185bb195b4daf0cff419988de757c6c31",
        strip_prefix = "rules_ts-2.4.2",
        url = "https://github.com/aspect-build/rules_ts/releases/download/v2.4.2/rules_ts-v2.4.2.tar.gz",
    )

    # git_repository(
    #     name = "com_github_grpc_grpc_web",
    #     commit = "e49389873d887d15ab2870288f620aa2f15b3b85",
    #     remote = "https://github.com/grpc/grpc-web.git",
    # )

    git_repository(
        name = "com_github_grpc_grpc_web",
        #        commit = "f6eb07753a3d004ea0022eec541bed975e7fa0e8",
        remote = "https://github.com/gonzojive/grpc-web.git",
        branch = "reddaly-dev",
    )
