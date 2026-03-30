allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// isar_flutter_libs 3.1.0+1 does not declare `namespace` (required by AGP 8+).
subprojects {
    plugins.withId("com.android.library") {
        if (name != "isar_flutter_libs") return@withId
        val androidExt = extensions.findByName("android") ?: return@withId
        try {
            androidExt.javaClass
                .getMethod("setNamespace", String::class.java)
                .invoke(androidExt, "dev.isar.isar_flutter_libs")
        } catch (_: Exception) {
            // If AGP changes or namespace already set, ignore.
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
