const std = @import("std");

pub fn Matrtix(
    comptime T: type,
    M: comptime_int,
    N: comptime_int,
) type {
    return struct {
        dt: T = @TypeOf(T),
        width: usize = M,
        height: usize = N,
        data: [M * N]T = .{0} ** M * N,

        const Self = @This();

        pub fn init() void {}
    };
}
