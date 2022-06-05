# Mocks, Fakes, Stubs and Dummies

Are you confused about what someone means when they say "test stub" or "mock object"? Do you sometimes feel that the person you are talking to is using a very different definition? Well, you are not alone!

The terminology around the various kinds of [Test Doubles](http://xunitpatterns.com/Test Double.html) *(page X)* is confusing and inconsistent. Different authors use different terms to mean the same thing. And sometimes they mean different things by the same term! Ouch! (See the sidebar [What's in a (Pattern) Name?](http://xunitpatterns.com/Whats in a Name.html) *(page X)* for why I think names are important.)

Part of the reason for writing this book was to try to establish some consistency in the terminology to give people a set of names with clear definitions of what they mean. In this sidebar, I provide a list of the current sources and cross-reference the terminology they use with what I use in this book.





## Role Descriptions

Here is a summary of what I mean by each of the major [Test Double](http://xunitpatterns.com/Test Double.html) pattern names:

| Pattern                                                      | Purpose                                      | Has Behavior | Injects [indirect inputs](http://xunitpatterns.com/indirect input.html) into SUT | Handles [indirect outputs](http://xunitpatterns.com/indirect output.html) of SUT | Values provided by test(er) | Examples                             |
| ------------------------------------------------------------ | -------------------------------------------- | ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | --------------------------- | ------------------------------------ |
| [Test Double](http://xunitpatterns.com/Test Double.html)     | Generic name for family                      |              |                                                              |                                                              |                             |                                      |
| [Dummy Object](http://xunitpatterns.com/Dummy Object.html) *(page X)* | Attribute or Method Parameter                | no           | no, never called                                             | no, never called                                             | no                          | Null, "Ignored String", new Object() |
| [Test Stub](http://xunitpatterns.com/Test Stub.html) *(page X)* | Verify indirect inputs of SUT                | yes          | yes                                                          | ignores them                                                 | inputs                      |                                      |
| [Test Spy](http://xunitpatterns.com/Test Spy.html) *(page X)* | Verify indirect outputs of SUT               | yes          | optional                                                     | captures them for later verification                         | inputs (optional)           |                                      |
| [Mock Object](http://xunitpatterns.com/Mock Object.html) *(page X)* | Verify indirect outputs of SUT               | yes          | optional                                                     | verifies correctness against expectations                    | outputs & inputs (optional) |                                      |
| [Fake Object](http://xunitpatterns.com/Fake Object.html) *(page X)* | Run (unrunnable) tests (faster)              | yes          | no                                                           | uses them                                                    | none                        | In-memory database emulator          |
| [Temporary Test Stub](http://xunitpatterns.com/Test Stub.html#Temporary Test Stub) *(see Test Stub)* | Stand in for procedural code not yet written | yes          | no                                                           | uses them                                                    | none                        | In-memory database emulator          |





## Terminology Cross-Reference

I'm listing some sources of conflicting definitions just to make it clear what the mapping is to my pattern names:

|                                                              | Sources and Names Used in them |      |          |        |       |       |      |                    |         |
| ------------------------------------------------------------ | ------------------------------ | ---- | -------- | ------ | ----- | ----- | ---- | ------------------ | ------- |
| Pattern                                                      | Astels                         | Beck | Feathers | Fowler | jMock | UTWJ  | OMG  | Pragmatic          | Recipes |
| [Test Double](http://xunitpatterns.com/Test Double.html)     |                                |      |          |        |       |       |      | Double or stand-in |         |
| [Dummy Object](http://xunitpatterns.com/Dummy Object.html)   | Stub                           |      |          |        | Dummy |       |      |                    | Stub    |
| [Test Stub](http://xunitpatterns.com/Test Stub.html)         | Fake                           |      | Fake     | Stub   | Stub  | Dummy |      | Mock               | Fake    |
| [Test Spy](http://xunitpatterns.com/Test Spy.html)           |                                |      |          |        |       | Dummy |      |                    | Spy     |
| [Mock Object](http://xunitpatterns.com/Mock Object.html)     | Mock                           |      | Mock     | Mock   | Mock  | Mock  |      | Mock               | Mock    |
| [Fake Object](http://xunitpatterns.com/Fake Object.html)     |                                |      |          |        |       | Dummy |      |                    |         |
| [Temporary Test Stub](http://xunitpatterns.com/Test Stub.html#Temporary Test Stub) |                                |      |          |        |       | Stub  |      |                    |         |
| OMG's CORBA Stub                                             |                                |      |          |        |       |       | Stub |                    |         |

Some specific examples from this table are:

- Unit Testing With Java ([[UTwJ\]](http://xunitpatterns.com/UTMJ.html)) uses the term "Dummy Object" to refer to what I am calling a "Fake Object".
- Pragmatic Unit Testing [[PUT\]](http://xunitpatterns.com/PUT.html) describes a "Stub" as an empty implementation of a method. This is a common interpretation in the procedural world but in the object world this is typically called a [Null Object](http://xunitpatterns.com/Null Object.html)[PLOPD3].
- Some of the early Mock Objects literature could be interpreted to equate a Stub with a Mock Object. This has since been clarified in [[MRNO\]](http://xunitpatterns.com/Mock Roles.html) and [[MAS\]](http://xunitpatterns.com/MAS.html).
- The CORBA standard (CORBA stands for Common Object Request Broker Architecture and is defined by the Object Management Group)and other remote-procedure call specifications use the terms "stubs" and "skeletons" to refer to the automatically generated code for the near and far end implementation of a remote interface defined in IDL. (I've only included this here because it is another use of one of the terms we commonly use in the TDD and automated developer testing community.)

The sources quoted in the table above are:

| Source    | Description                              | Citation                                                     | Publisher             |
| --------- | ---------------------------------------- | ------------------------------------------------------------ | --------------------- |
| Astels    | Book: Test-Driven Development            | [[TDD-APG\]](http://xunitpatterns.com/TDD-A Practical Guide.html) | Pearson               |
| Beck      | Book: Test-Driven Development            | [[TDD-BE\]](http://xunitpatterns.com/TDD-Beck.html)          | Pearson               |
| Feathers  | Book: Working with Legacy Code           | [[WEwLC\]](http://xunitpatterns.com/WEwLC.html)              | Prentis Hall          |
| Fowler    | Blog: Mocks are Stubs                    | [[MAS\]](http://xunitpatterns.com/MAS.html)                  | martinfowler.com      |
| jMock     | Paper: Mock Roles Not Objects            | [[MRNO\]](http://xunitpatterns.com/Mock Roles.html)          | ACM (OOPSLA)          |
| UTWJ      | Book: Unit Testing With Java             | [[UTwJ\]](http://xunitpatterns.com/UTMJ.html)                | Morgan Kaufmann       |
| OMG       | Object Management Group's CORBA specs    |                                                              | OMG                   |
| Pragmatic | Book: Pragmatic Unit Testing with Nunit  | [[PUT\]](http://xunitpatterns.com/PUT.html)                  | Pragmatic Programmers |
| Recipes   | Book: JUnit Recipes                      | [[MRNO\]](http://xunitpatterns.com/Mock Roles.html)          | Wiley                 |
| .Net      | Book: Test-Driven Development in MS .NET | [[TDD.Net\]](http://xunitpatterns.com/TDD-DotNet.html)       | Microsoft Press       |





## Feedback Requested

I need your feedback! Which names make sense to you? Which ones don't? What would you suggest instead?

Please post any comments on the Yahoo! group created for this purpose:

http://groups.yahoo.com/group/xunitpatterns/post


Page generated at Wed Feb 09 16:38:57 +1100 2011

Copyright © 2003-2008 [Gerard Meszaros](mailto:testautomationpatterns_at_gerardmeszaros.com) all rights reserved