ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.13.8"

lazy val root = (project in file("."))
	.settings(
		name := "proj-rv64"
	)
scalacOptions ++= Seq(
	"-Xsource:2.13"
)

addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.5.4" cross CrossVersion.full)


libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.5.5"
// We also recommend using chiseltest for writing unit tests
libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "0.5.5" % "test"
libraryDependencies += "com.sifive"%%"chisel-circt"%"0.8.0"



libraryDependencies += "org.scala-lang.modules" %% "scala-swing" % "3.0.0"



