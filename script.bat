@echo off
REM Set the path to Karate JAR
set KARATE_JAR=karate.jar

REM Create the output directory for compiled classes if it does not exist
if not exist target\test-classes mkdir target\test-classes

REM Compile Java classes
javac -d target\test-classes src\test\java\Uuid\prdUnique.java src\test\java\Uuid\TestRunner.java

REM Run the Karate feature
