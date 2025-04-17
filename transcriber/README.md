
Transcriber
==================================

Description
----------------------------------

### Structure

```
+---------------------------------------------------------------------------------------+
|                              Structure of Transcriber Rules                           |
+--------------------------+---------------+-------------------------+------------------+
|          F1              |       F2      |          F3             |        F4        |
+--------------------------+---------------+-------------------------+------------------+
| [_] [Prev. Syllable] [%] | Cur. Syllable | [%] [Next Syllable] [_] | X-SAMPA Syllable |
+--------------------------+---------------+-------------------------+------------------+
```

* `F1`: an optional regex for the previous syllable.
* `F2`: a regex for the current syllable.
* `F3`: an optional regex for the next syllable.
* `F4`: a X-SAMPA transcription of the current syllable.

* `%`: an optional underline symbol that indicates the current syllable is near to the start or end of a word (the boundaries).
* `_`: an optional percent symbol that indicates that the strongest syllable (the stress) in a word is before or after the current syllable.

```
+---------------------------------------------------------------------------------------+
|                              Examples of Transcriber Rules                            |
+--------------------------+---------------+-------------------------+------------------+
|          F1              |       F2      |           F3            |        F4        |
+--------------------------+---------------+-------------------------+------------------+
|                          |      bla      |                         |       bla        |  // dri.bla.ram [dri.'bla.ra~U]
+--------------------------+---------------+-------------------------+------------------+
|                          |      bla      |           _             |       bl@        |  // dri.bla ['dri.bl@]
+--------------------------+---------------+-------------------------+------------------+
|                          |      blá      |                         |       'bla       |  // dri.blá.vel [dri.'bla.veU]
+--------------------------+---------------+-------------------------+------------------+
|                          |      ção      |           _             |      'sa~U       |  // a.ção [a.'sa~U]
+--------------------------+---------------+-------------------------+------------------+
|           %              |      ção      |           _             |       sa~U       |  // bên.ção ['be~.sa~U]
+--------------------------+---------------+-------------------------+------------------+
```

Demonstration
----------------------------------


