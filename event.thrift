# Example frugal file. Frugal is a superset of Thrift, meaning this file can
# contain valid Thrift or Frugal-extended syntax.
namespace java example
namespace py example

include "base.thrift"

typedef i64 id
typedef i32 int
typedef map<int, string> request

/**
 * This docstring doesn't get added to the generated code because
 * it doesn't have the @ sign.
 */
const id DEFAULT_ID = -1

/**@
 * This docstring gets added to the generated code because it has
 * the @ sign.
 */
struct Event {
    /**@ ID is a unique identifier for an event. */
    1: id ID = DEFAULT_ID,

    /**@ Message contains the event payload. */
    2: string Message
}

exception AwesomeException {
    /**@ ID is a unique identifier for an awesome exception. */
    1: id ID,

    /**@ Reason contains the error message. */
    2: string Reason
}

/**@
 * This is a thrift service. Frugal will generate bindings that include
 * a frugal Context for each service call.
 */
service Foo extends base.BaseFoo {
    /**@ Ping the server. */
    void ping(),

    /**@ Blah the server. */
    i64 blah(1:i32 num, 2:string Str, 3:Event event) throws (1:AwesomeException awe, 2:base.api_exception api),

    /**@ oneway methods don't receive a response from the server. */
    oneway void oneWay(1:id id, 2:request req)
}
