const std = @import("std");

const vec2 = @import("vec2.zig");
const vec3 = @import("vec3.zig");
const vec4 = @import("vec4.zig");

pub const Vec2 = vec2.Vec2;
pub const Point2 = Vec2;

pub const Vec3 = vec3.Vec3;
pub const Point3 = Vec3;

pub const Vec4 = vec4.Vec4;
pub const Point4 = Vec4;

test "Test all" {
    std.testing.refAllDecls(@This());
}
