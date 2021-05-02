# The C Preprocessor





## Table of Contents

- 1 Overview
  - [1.1 Character sets](https://gcc.gnu.org/onlinedocs/cpp/Character-sets.html#Character-sets)
  - [1.2 Initial processing](https://gcc.gnu.org/onlinedocs/cpp/Initial-processing.html#Initial-processing)
  - [1.3 Tokenization](https://gcc.gnu.org/onlinedocs/cpp/Tokenization.html#Tokenization)
  - [1.4 The preprocessing language](https://gcc.gnu.org/onlinedocs/cpp/The-preprocessing-language.html#The-preprocessing-language)
- 2 Header Files
  - [2.1 Include Syntax](https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html#Include-Syntax)
  - [2.2 Include Operation](https://gcc.gnu.org/onlinedocs/cpp/Include-Operation.html#Include-Operation)
  - [2.3 Search Path](https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html#Search-Path)
  - [2.4 Once-Only Headers](https://gcc.gnu.org/onlinedocs/cpp/Once-Only-Headers.html#Once-Only-Headers)
  - [2.5 Alternatives to Wrapper #ifndef](https://gcc.gnu.org/onlinedocs/cpp/Alternatives-to-Wrapper-_0023ifndef.html#Alternatives-to-Wrapper-_0023ifndef)
  - [2.6 Computed Includes](https://gcc.gnu.org/onlinedocs/cpp/Computed-Includes.html#Computed-Includes)
  - [2.7 Wrapper Headers](https://gcc.gnu.org/onlinedocs/cpp/Wrapper-Headers.html#Wrapper-Headers)
  - [2.8 System Headers](https://gcc.gnu.org/onlinedocs/cpp/System-Headers.html#System-Headers)
- 3 Macros
  - [3.1 Object-like Macros](https://gcc.gnu.org/onlinedocs/cpp/Object-like-Macros.html#Object-like-Macros)
  - [3.2 Function-like Macros](https://gcc.gnu.org/onlinedocs/cpp/Function-like-Macros.html#Function-like-Macros)
  - [3.3 Macro Arguments](https://gcc.gnu.org/onlinedocs/cpp/Macro-Arguments.html#Macro-Arguments)
  - [3.4 Stringizing](https://gcc.gnu.org/onlinedocs/cpp/Stringizing.html#Stringizing)
  - [3.5 Concatenation](https://gcc.gnu.org/onlinedocs/cpp/Concatenation.html#Concatenation)
  - [3.6 Variadic Macros](https://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html#Variadic-Macros)
  - 3.7 Predefined Macros
    - [3.7.1 Standard Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html#Standard-Predefined-Macros)
    - [3.7.2 Common Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros)
    - [3.7.3 System-specific Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/System-specific-Predefined-Macros.html#System-specific-Predefined-Macros)
    - [3.7.4 C++ Named Operators](https://gcc.gnu.org/onlinedocs/cpp/C_002b_002b-Named-Operators.html#C_002b_002b-Named-Operators)
  - [3.8 Undefining and Redefining Macros](https://gcc.gnu.org/onlinedocs/cpp/Undefining-and-Redefining-Macros.html#Undefining-and-Redefining-Macros)
  - [3.9 Directives Within Macro Arguments](https://gcc.gnu.org/onlinedocs/cpp/Directives-Within-Macro-Arguments.html#Directives-Within-Macro-Arguments)
  - 3.10 Macro Pitfalls
    - [3.10.1 Misnesting](https://gcc.gnu.org/onlinedocs/cpp/Misnesting.html#Misnesting)
    - [3.10.2 Operator Precedence Problems](https://gcc.gnu.org/onlinedocs/cpp/Operator-Precedence-Problems.html#Operator-Precedence-Problems)
    - [3.10.3 Swallowing the Semicolon](https://gcc.gnu.org/onlinedocs/cpp/Swallowing-the-Semicolon.html#Swallowing-the-Semicolon)
    - [3.10.4 Duplication of Side Effects](https://gcc.gnu.org/onlinedocs/cpp/Duplication-of-Side-Effects.html#Duplication-of-Side-Effects)
    - [3.10.5 Self-Referential Macros](https://gcc.gnu.org/onlinedocs/cpp/Self-Referential-Macros.html#Self-Referential-Macros)
    - [3.10.6 Argument Prescan](https://gcc.gnu.org/onlinedocs/cpp/Argument-Prescan.html#Argument-Prescan)
    - [3.10.7 Newlines in Arguments](https://gcc.gnu.org/onlinedocs/cpp/Newlines-in-Arguments.html#Newlines-in-Arguments)
- 4 Conditionals
  - [4.1 Conditional Uses](https://gcc.gnu.org/onlinedocs/cpp/Conditional-Uses.html#Conditional-Uses)
  - 4.2 Conditional Syntax
    - [4.2.1 Ifdef](https://gcc.gnu.org/onlinedocs/cpp/Ifdef.html#Ifdef)
    - [4.2.2 If](https://gcc.gnu.org/onlinedocs/cpp/If.html#If)
    - [4.2.3 Defined](https://gcc.gnu.org/onlinedocs/cpp/Defined.html#Defined)
    - [4.2.4 Else](https://gcc.gnu.org/onlinedocs/cpp/Else.html#Else)
    - [4.2.5 Elif](https://gcc.gnu.org/onlinedocs/cpp/Elif.html#Elif)
    - [4.2.6 `__has_attribute`](https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fattribute.html#g_t_005f_005fhas_005fattribute)
    - [4.2.7 `__has_cpp_attribute`](https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fcpp_005fattribute.html#g_t_005f_005fhas_005fcpp_005fattribute)
    - [4.2.8 `__has_c_attribute`](https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fc_005fattribute.html#g_t_005f_005fhas_005fc_005fattribute)
    - [4.2.9 `__has_builtin`](https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005fbuiltin.html#g_t_005f_005fhas_005fbuiltin)
    - [4.2.10 `__has_include`](https://gcc.gnu.org/onlinedocs/cpp/_005f_005fhas_005finclude.html#g_t_005f_005fhas_005finclude)
  - [4.3 Deleted Code](https://gcc.gnu.org/onlinedocs/cpp/Deleted-Code.html#Deleted-Code)
- [5 Diagnostics](https://gcc.gnu.org/onlinedocs/cpp/Diagnostics.html#Diagnostics)
- [6 Line Control](https://gcc.gnu.org/onlinedocs/cpp/Line-Control.html#Line-Control)
- [7 Pragmas](https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html#Pragmas)
- [8 Other Directives](https://gcc.gnu.org/onlinedocs/cpp/Other-Directives.html#Other-Directives)
- [9 Preprocessor Output](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html#Preprocessor-Output)
- 10 Traditional Mode
  - [10.1 Traditional lexical analysis](https://gcc.gnu.org/onlinedocs/cpp/Traditional-lexical-analysis.html#Traditional-lexical-analysis)
  - [10.2 Traditional macros](https://gcc.gnu.org/onlinedocs/cpp/Traditional-macros.html#Traditional-macros)
  - [10.3 Traditional miscellany](https://gcc.gnu.org/onlinedocs/cpp/Traditional-miscellany.html#Traditional-miscellany)
  - [10.4 Traditional warnings](https://gcc.gnu.org/onlinedocs/cpp/Traditional-warnings.html#Traditional-warnings)
- 11 Implementation Details
  - [11.1 Implementation-defined behavior](https://gcc.gnu.org/onlinedocs/cpp/Implementation-defined-behavior.html#Implementation-defined-behavior)
  - [11.2 Implementation limits](https://gcc.gnu.org/onlinedocs/cpp/Implementation-limits.html#Implementation-limits)
  - 11.3 Obsolete Features
    - [11.3.1 Assertions](https://gcc.gnu.org/onlinedocs/cpp/Obsolete-Features.html#Assertions)
- [12 Invocation](https://gcc.gnu.org/onlinedocs/cpp/Invocation.html#Invocation)
- [13 Environment Variables](https://gcc.gnu.org/onlinedocs/cpp/Environment-Variables.html#Environment-Variables)
- GNU Free Documentation License
  - [ADDENDUM: How to use this License for your documents](https://gcc.gnu.org/onlinedocs/cpp/GNU-Free-Documentation-License.html#ADDENDUM_003a-How-to-use-this-License-for-your-documents)
- [Index of Directives](https://gcc.gnu.org/onlinedocs/cpp/Index-of-Directives.html#Index-of-Directives)
- [Option Index](https://gcc.gnu.org/onlinedocs/cpp/Option-Index.html#Option-Index)
- [Concept Index](https://gcc.gnu.org/onlinedocs/cpp/Concept-Index.html#Concept-Index)





Next: [Overview](https://gcc.gnu.org/onlinedocs/cpp/Overview.html#Overview), Up: [(dir)](https://gcc.gnu.org/onlinedocs/dir/index.html)   [[Contents](https://gcc.gnu.org/onlinedocs/cpp/#SEC_Contents)][[Index](https://gcc.gnu.org/onlinedocs/cpp/Index-of-Directives.html#Index-of-Directives)]

------





The C preprocessor implements the macro language used to transform C, C++, and Objective-C programs before they are compiled. It can also be useful on its own.

| • [Overview](https://gcc.gnu.org/onlinedocs/cpp/Overview.html#Overview): |      |      |
| ------------------------------------------------------------ | ---- | ---- |
| • [Header Files](https://gcc.gnu.org/onlinedocs/cpp/Header-Files.html#Header-Files): |      |      |
| • [Macros](https://gcc.gnu.org/onlinedocs/cpp/Macros.html#Macros): |      |      |
| • [Conditionals](https://gcc.gnu.org/onlinedocs/cpp/Conditionals.html#Conditionals): |      |      |
| • [Diagnostics](https://gcc.gnu.org/onlinedocs/cpp/Diagnostics.html#Diagnostics): |      |      |
| • [Line Control](https://gcc.gnu.org/onlinedocs/cpp/Line-Control.html#Line-Control): |      |      |
| • [Pragmas](https://gcc.gnu.org/onlinedocs/cpp/Pragmas.html#Pragmas): |      |      |
| • [Other Directives](https://gcc.gnu.org/onlinedocs/cpp/Other-Directives.html#Other-Directives): |      |      |
| • [Preprocessor Output](https://gcc.gnu.org/onlinedocs/cpp/Preprocessor-Output.html#Preprocessor-Output): |      |      |
| • [Traditional Mode](https://gcc.gnu.org/onlinedocs/cpp/Traditional-Mode.html#Traditional-Mode): |      |      |
| • [Implementation Details](https://gcc.gnu.org/onlinedocs/cpp/Implementation-Details.html#Implementation-Details): |      |      |
| • [Invocation](https://gcc.gnu.org/onlinedocs/cpp/Invocation.html#Invocation): |      |      |
| • [Environment Variables](https://gcc.gnu.org/onlinedocs/cpp/Environment-Variables.html#Environment-Variables): |      |      |
| • [GNU Free Documentation License](https://gcc.gnu.org/onlinedocs/cpp/GNU-Free-Documentation-License.html#GNU-Free-Documentation-License): |      |      |
| • [Index of Directives](https://gcc.gnu.org/onlinedocs/cpp/Index-of-Directives.html#Index-of-Directives): |      |      |
| • [Option Index](https://gcc.gnu.org/onlinedocs/cpp/Option-Index.html#Option-Index): |      |      |
| • [Concept Index](https://gcc.gnu.org/onlinedocs/cpp/Concept-Index.html#Concept-Index): |      |      |
| ``                                                           |      |      |
| ` — The Detailed Node Listing —  Overview  `                 |      |      |
| • [Character sets](https://gcc.gnu.org/onlinedocs/cpp/Character-sets.html#Character-sets): |      |      |
| • [Initial processing](https://gcc.gnu.org/onlinedocs/cpp/Initial-processing.html#Initial-processing): |      |      |
| • [Tokenization](https://gcc.gnu.org/onlinedocs/cpp/Tokenization.html#Tokenization): |      |      |
| • [The preprocessing language](https://gcc.gnu.org/onlinedocs/cpp/The-preprocessing-language.html#The-preprocessing-language): |      |      |
| `Header Files  `                                             |      |      |
| • [Include Syntax](https://gcc.gnu.org/onlinedocs/cpp/Include-Syntax.html#Include-Syntax): |      |      |
| • [Include Operation](https://gcc.gnu.org/onlinedocs/cpp/Include-Operation.html#Include-Operation): |      |      |
| • [Search Path](https://gcc.gnu.org/onlinedocs/cpp/Search-Path.html#Search-Path): |      |      |
| • [Once-Only Headers](https://gcc.gnu.org/onlinedocs/cpp/Once-Only-Headers.html#Once-Only-Headers): |      |      |
| • [Alternatives to Wrapper #ifndef](https://gcc.gnu.org/onlinedocs/cpp/Alternatives-to-Wrapper-_0023ifndef.html#Alternatives-to-Wrapper-_0023ifndef): |      |      |
| • [Computed Includes](https://gcc.gnu.org/onlinedocs/cpp/Computed-Includes.html#Computed-Includes): |      |      |
| • [Wrapper Headers](https://gcc.gnu.org/onlinedocs/cpp/Wrapper-Headers.html#Wrapper-Headers): |      |      |
| • [System Headers](https://gcc.gnu.org/onlinedocs/cpp/System-Headers.html#System-Headers): |      |      |
| `Macros  `                                                   |      |      |
| • [Object-like Macros](https://gcc.gnu.org/onlinedocs/cpp/Object-like-Macros.html#Object-like-Macros): |      |      |
| • [Function-like Macros](https://gcc.gnu.org/onlinedocs/cpp/Function-like-Macros.html#Function-like-Macros): |      |      |
| • [Macro Arguments](https://gcc.gnu.org/onlinedocs/cpp/Macro-Arguments.html#Macro-Arguments): |      |      |
| • [Stringizing](https://gcc.gnu.org/onlinedocs/cpp/Stringizing.html#Stringizing): |      |      |
| • [Concatenation](https://gcc.gnu.org/onlinedocs/cpp/Concatenation.html#Concatenation): |      |      |
| • [Variadic Macros](https://gcc.gnu.org/onlinedocs/cpp/Variadic-Macros.html#Variadic-Macros): |      |      |
| • [Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/Predefined-Macros.html#Predefined-Macros): |      |      |
| • [Undefining and Redefining Macros](https://gcc.gnu.org/onlinedocs/cpp/Undefining-and-Redefining-Macros.html#Undefining-and-Redefining-Macros): |      |      |
| • [Directives Within Macro Arguments](https://gcc.gnu.org/onlinedocs/cpp/Directives-Within-Macro-Arguments.html#Directives-Within-Macro-Arguments): |      |      |
| • [Macro Pitfalls](https://gcc.gnu.org/onlinedocs/cpp/Macro-Pitfalls.html#Macro-Pitfalls): |      |      |
| `Predefined Macros  `                                        |      |      |
| • [Standard Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/Standard-Predefined-Macros.html#Standard-Predefined-Macros): |      |      |
| • [Common Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html#Common-Predefined-Macros): |      |      |
| • [System-specific Predefined Macros](https://gcc.gnu.org/onlinedocs/cpp/System-specific-Predefined-Macros.html#System-specific-Predefined-Macros): |      |      |
| • [C++ Named Operators](https://gcc.gnu.org/onlinedocs/cpp/C_002b_002b-Named-Operators.html#C_002b_002b-Named-Operators): |      |      |
| `Macro Pitfalls  `                                           |      |      |
| • [Misnesting](https://gcc.gnu.org/onlinedocs/cpp/Misnesting.html#Misnesting): |      |      |
| • [Operator Precedence Problems](https://gcc.gnu.org/onlinedocs/cpp/Operator-Precedence-Problems.html#Operator-Precedence-Problems): |      |      |
| • [Swallowing the Semicolon](https://gcc.gnu.org/onlinedocs/cpp/Swallowing-the-Semicolon.html#Swallowing-the-Semicolon): |      |      |
| • [Duplication of Side Effects](https://gcc.gnu.org/onlinedocs/cpp/Duplication-of-Side-Effects.html#Duplication-of-Side-Effects): |      |      |
| • [Self-Referential Macros](https://gcc.gnu.org/onlinedocs/cpp/Self-Referential-Macros.html#Self-Referential-Macros): |      |      |
| • [Argument Prescan](https://gcc.gnu.org/onlinedocs/cpp/Argument-Prescan.html#Argument-Prescan): |      |      |
| • [Newlines in Arguments](https://gcc.gnu.org/onlinedocs/cpp/Newlines-in-Arguments.html#Newlines-in-Arguments): |      |      |
| `Conditionals  `                                             |      |      |
| • [Conditional Uses](https://gcc.gnu.org/onlinedocs/cpp/Conditional-Uses.html#Conditional-Uses): |      |      |
| • [Conditional Syntax](https://gcc.gnu.org/onlinedocs/cpp/Conditional-Syntax.html#Conditional-Syntax): |      |      |
| • [Deleted Code](https://gcc.gnu.org/onlinedocs/cpp/Deleted-Code.html#Deleted-Code): |      |      |
| `Conditional Syntax  `                                       |      |      |
| • [Ifdef](https://gcc.gnu.org/onlinedocs/cpp/Ifdef.html#Ifdef): |      |      |
| • [If](https://gcc.gnu.org/onlinedocs/cpp/If.html#If):       |      |      |
| • [Defined](https://gcc.gnu.org/onlinedocs/cpp/Defined.html#Defined): |      |      |
| • [Else](https://gcc.gnu.org/onlinedocs/cpp/Else.html#Else): |      |      |
| • [Elif](https://gcc.gnu.org/onlinedocs/cpp/Elif.html#Elif): |      |      |
| `Implementation Details  `                                   |      |      |
| • [Implementation-defined behavior](https://gcc.gnu.org/onlinedocs/cpp/Implementation-defined-behavior.html#Implementation-defined-behavior): |      |      |
| • [Implementation limits](https://gcc.gnu.org/onlinedocs/cpp/Implementation-limits.html#Implementation-limits): |      |      |
| • [Obsolete Features](https://gcc.gnu.org/onlinedocs/cpp/Obsolete-Features.html#Obsolete-Features): |      |      |
| `Obsolete Features  `                                        |      |      |
| • [Obsolete Features](https://gcc.gnu.org/onlinedocs/cpp/Obsolete-Features.html#Obsolete-Features): |      |      |
| ``                                                           |      |      |

Copyright © 1987-2021 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation. A copy of the license is included in the section entitled “GNU Free Documentation License”.

This manual contains no Invariant Sections. The Front-Cover Texts are (a) (see below), and the Back-Cover Texts are (b) (see below).

(a) The FSF’s Front-Cover Text is:

A GNU Manual

(b) The FSF’s Back-Cover Text is:

You have freedom to copy and modify this GNU Manual, like GNU software. Copies published by the Free Software Foundation raise funds for GNU development.

------

Next: [Overview](https://gcc.gnu.org/onlinedocs/cpp/Overview.html#Overview), Up: [(dir)](https://gcc.gnu.org/onlinedocs/dir/index.html)   [[Contents](https://gcc.gnu.org/onlinedocs/cpp/#SEC_Contents)][[Index](https://gcc.gnu.org/onlinedocs/cpp/Index-of-Directives.html#Index-of-Directives)]