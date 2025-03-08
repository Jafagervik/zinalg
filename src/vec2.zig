const std = @import("std");
const testing = std.testing;
const math = std.math;

pub fn Vec2(comptime T: type) type {
    return struct {
        const Self = @This();

        e: [2]T,

        pub fn init(e0: T, e1: T) Self {
            return Self{ .e = [_]T{ e0, e1 } };
        }

        pub fn empty() Self {
            return Self{ .e = [_]T{ 0, 0 } };
        }

        /// Get the x value
        pub fn x(self: Self) T {
            return self.e[0];
        }

        /// Get the y value
        pub fn y(self: Self) T {
            return self.e[1];
        }

        /// Negates the values of the vector
        pub fn negate(self: Self) Self {
            return Self.init(-self.e[0], -self.e[1]);
        }

        pub fn get(self: Self, i: usize) T {
            return self.e[i];
        }

        pub fn getPtr(self: *Self, i: usize) *T {
            return &self.e[i];
        }

        /// Add a vector to it self
        pub fn add(self: *Self, v: Self) *Self {
            self.e[0] += v.e[0];
            self.e[1] += v.e[1];
            return self;
        }

        /// Scale the vector by a scalar
        pub fn scale(self: *Self, t: T) *Self {
            self.e[0] *= t;
            self.e[1] *= t;
            return self;
        }

        /// Divide the vector by a scalar
        pub fn divide(self: *Self, t: T) *Self {
            // TODO: Assert
            return self.scale(1.0 / t);
        }

        /// Get the length of the vector
        pub fn length(self: Self) T {
            return math.sqrt(self.lengthSquared());
        }

        pub fn lengthSquared(self: Self) T {
            return self.e[0] * self.e[0] + self.e[1] * self.e[1];
        }

        // Utility functions that don't modify self
        pub fn plus(self: Self, v: Self) Self {
            return Self.init(
                self.e[0] + v.e[0],
                self.e[1] + v.e[1],
            );
        }

        pub fn minus(self: Self, v: Self) Self {
            return Self.init(
                self.e[0] - v.e[0],
                self.e[1] - v.e[1],
            );
        }

        pub fn mul(self: Self, v: Self) Self {
            return Self.init(
                self.e[0] * v.e[0],
                self.e[1] * v.e[1],
            );
        }

        pub fn addScalar(self: Self, t: T) Self {
            return Self.init(t + self.e[0], t + self.e[1]);
        }

        pub fn mulScalar(self: Self, t: T) Self {
            return Self.init(t * self.e[0], t * self.e[1]);
        }

        pub fn divScalar(self: Self, t: T) Self {
            return self.mulScalar(1.0 / t);
        }

        /// Formats the vector
        pub fn format(writer: anytype, vec: Self) !void {
            try writer.print("{d} {d}", .{ vec.e[0], vec.e[1] });
        }

        /// Directly prints the vector
        pub fn print(vec: Self) void {
            std.debug.print("Vec2: [{d} {d}]\n", .{ vec.e[0], vec.e[1] });
        }

        /// Dot product between two vectors
        pub inline fn dot(u: Self, v: Self) T {
            return u.e[0] * v.e[0] + u.e[1] * v.e[1];
        }

        /// Gets the unit vector
        pub inline fn unitVector(v: Self) Self {
            return v.divScalar(v.length());
        }
    };
}

test "f16" {
    const v: Vec2(f16) = .init(1.0, 2.0);

    try testing.expectEqual(5.0, v.lengthSquared());
}

test "f32" {
    const v: Vec2(f32) = .init(1.0, 2.0);

    try testing.expectEqual(5.0, v.lengthSquared());
}

test "f64" {
    const v: Vec2(f64) = .init(1.0, 2.0);

    try testing.expectEqual(5.0, v.lengthSquared());
}
