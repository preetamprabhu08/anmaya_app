plugins {
  id("com.google.gms.google-services") version "4.4.2" apply false

}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir = File(rootProject.projectDir.parentFile, "build")
rootProject.buildDir = newBuildDir

subprojects {
    val newSubprojectBuildDir = File(newBuildDir, project.name)
    project.buildDir = newSubprojectBuildDir
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
