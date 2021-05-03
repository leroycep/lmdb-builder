const std = @import("std");
const LibExeObjStep = std.build.LibExeObjStep;
const Builder = std.build.Builder;
const fs = std.fs;

pub fn addTo(b: *Builder, base_dir: []const u8, obj: *LibExeObjStep) void {
    const src_dir = fs.path.join(b.allocator, &.{ base_dir, "libraries/liblmdb" }) catch unreachable;
    obj.addIncludeDir(src_dir);
    obj.addCSourceFiles(
        &.{
            fs.path.join(b.allocator, &.{ src_dir, "mdb.c" }) catch unreachable,
            fs.path.join(b.allocator, &.{ src_dir, "midl.c" }) catch unreachable,
        },
        &.{"-fno-sanitize=undefined"},
    );
    obj.linkLibC();
}
