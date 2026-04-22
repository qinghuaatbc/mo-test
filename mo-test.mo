# mo-test.mo — unit testing framework for Mo
# Install: mo install qinghuaatbc/mo-test
#
# Usage (with namespace):
#   import "mo-test" as t
#   t.describe("math", fn() {
#     t.it("1+1=2", fn() { t.expect(1+1, 2) })
#   })
#   t.summary()
#
# Usage (flat):
#   import "mo-test"
#   describe("math", fn() { it("1+1=2", fn() { expect(1+1, 2) }) })
#   summary()

let _passed = 0
let _failed = 0

fn describe(name, fn_body) {
    print("\n" + name)
    fn_body()
}

fn it(desc, fn_body) {
    try {
        fn_body()
        _passed = _passed + 1
        print("  [PASS] " + desc)
    } catch e {
        _failed = _failed + 1
        print("  [FAIL] " + desc + " -- " + str(e))
    }
}

fn expect(actual, expected) {
    if actual != expected {
        throw "expected " + str(expected) + ", got " + str(actual)
    }
}

fn expect_true(val) {
    if val != true {
        throw "expected true, got " + str(val)
    }
}

fn expect_false(val) {
    if val != false {
        throw "expected false, got " + str(val)
    }
}

fn expect_throws(fn_body) {
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

fn expect_null(val) {
    if val != null {
        throw "expected null, got " + str(val)
    }
}

fn expect_type(val, expected_type) {
    let t = type(val)
    if t != expected_type {
        throw "expected type " + expected_type + ", got " + t
    }
}

fn summary() {
    let total = _passed + _failed
    print("\n" + str(_passed) + "/" + str(total) + " passed")
    if _failed > 0 {
        throw str(_failed) + " test(s) failed"
    }
}
