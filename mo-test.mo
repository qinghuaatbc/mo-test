# mo-test.mo — unit testing framework for Mo
# Install: mo install qinghuaatbc/mo-test
# Usage:
#   import "mo-test" as t
#   t.describe("math", fn() {
#     t.it("addition", fn() { t.expect(1 + 1, 2) })
#     t.it("division", fn() { t.expect(10 // 3, 3) })
#   })
#   t.summary()

let test_passed = 0
let test_failed = 0

fn test_describe(name, fn_body) {
    print("\n" + name)
    fn_body()
}

fn test_it(desc, fn_body) {
    try {
        fn_body()
        test_passed = test_passed + 1
        print("  [PASS] " + desc)
    } catch e {
        test_failed = test_failed + 1
        print("  [FAIL] " + desc + " -- " + str(e))
    }
}

fn test_expect(actual, expected) {
    if actual != expected {
        throw "expected " + str(expected) + ", got " + str(actual)
    }
}

fn test_expect_true(val) {
    if val != true {
        throw "expected true, got " + str(val)
    }
}

fn test_expect_false(val) {
    if val != false {
        throw "expected false, got " + str(val)
    }
}

fn test_expect_throws(fn_body) {
    let threw = false
    try {
        fn_body()
    } catch e {
        threw = true
    }
    if threw != true {
        throw "expected an exception but none was thrown"
    }
}

fn test_expect_null(val) {
    if val != null {
        throw "expected null, got " + str(val)
    }
}

fn test_expect_type(val, expected_type) {
    let t = type(val)
    if t != expected_type {
        throw "expected type " + expected_type + ", got " + t
    }
}

fn test_summary() {
    let total = test_passed + test_failed
    print("\n" + str(test_passed) + "/" + str(total) + " passed")
    if test_failed > 0 {
        throw str(test_failed) + " test(s) failed"
    }
}
