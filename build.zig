const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zinalg_mod = b.createModule(.{
        .root_source_file = b.path("src/zinalg.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .name = "zinalg",
        .root_module = zinalg_mod,
        .linkage = .static,
    });

    b.installArtifact(lib);

    const lib_unit_tests = b.addTest(.{
        .root_module = zinalg_mod,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
}
