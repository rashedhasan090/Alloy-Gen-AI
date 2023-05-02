#!/bin/bash

# Find all Alloy files and run JAR file on each of them
find . -name '*.als' -type f -exec java -jar solver_new.jar {} \;
