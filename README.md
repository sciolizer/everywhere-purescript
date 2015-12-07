Purescript everywhere
=====================

Demonstrates how to run a purescript program in various environments.

Node
----

```
cd purescript
pulp run
```

Browser
-------

```
cd purescript
pulp browserify > ../browser/app.js
cd ../browser
open index.html
```

Java
----

```
cd purescript
pulp browserify > ../java/app.js
cd ../java
javac Main.java
java Main
```
