# coAP

[http://coap.technology/](http://coap.technology/)


Constrained Application Protocol
## homepage

# CoAP

## RFC 7252 Constrained Application Protocol

“The Constrained Application Protocol (CoAP) is a specialized web transfer protocol for use with constrained nodes and constrained networks in the **Internet of Things.**
The protocol is designed for machine-to-machine (M2M) applications such as smart energy and building automation.”

------

## REST model for small devices

Like HTTP, CoAP is based on the wildly successful REST model: Servers make resources available under a URL, and clients access these resources using methods such as GET, PUT, POST, and DELETE.

### Existing skills transfer

From a developer point of view, CoAP feels very much like HTTP. Obtaining a value from a sensor is not much different from obtaining a value from a Web API.

### Ready for integration

Since HTTP and CoAP share the REST model, they can easily be connected using application-agnostic cross-protocol proxies. A Web client may not even notice that it just accessed a sensor resource!

### Choose your data model

Like HTTP, CoAP can carry different types of payloads, and can identify which payload type is being used. CoAP integrates with XML, JSON, [CBOR,](http://cbor.io/) or any data format of your choice.

## Made for billions of nodes

The Internet of Things will need billions of nodes, many of which will need to be inexpensive. CoAP has been designed to work on microcontrollers with as low as 10 KiB of RAM and 100 KiB of code space ([RFC 7228](http://tools.ietf.org/html/rfc7228)).

### Keep waste in check

CoAP is designed to use minimal resources, both on the device and on the network. Instead of a complex transport stack, it gets by with UDP on IP. A 4-byte fixed header and a compact encoding of options enables small messages that cause no or little fragmentation on the link layer. Many servers can operate in a completely stateless fashion.

### Discovery integrated

The CoAP resource directory provides a way to discover the properties of the nodes on your network.

## Well-designed protocol

CoAP was developed as an Internet Standards Document, [RFC 7252.](http://coap.technology/spec.html) The protocol has been designed to last for decades. Difficult issues such as congestion control have not been swept under the rug, but have been addressed using the state of the art.

### Secure

The Internet of Things cannot spread as long as it can be exploited by hackers willy-nilly. CoAP does not just pay lip service to security, it actually provides strong security. CoAP's default choice of DTLS parameters is equivalent to 3072-bit RSA keys, yet still runs fine on the smallest nodes.