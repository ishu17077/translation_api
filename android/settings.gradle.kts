pluginManagement{
    val properties = java.util.Properties().apply {
        val localPropertiesFile = file("local.properties")
        if (localPropertiesFile.exists()) {
            localPropertiesFile.inputStream().use { load(it) }
        }
    }

    val flutterSdkPath = properties.getProperty("flutter.sdk")
        ?: throw IllegalStateException("flutter.sdk not set in local.properties")

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories{
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
plugins{
    id("dev.flutter.flutter-plugin-loader") version("1.0.0")
    id("com.android.application") version("9.3.0") apply(false)
    id("org.jetbrains.kotlin.android") version("2.1.0") apply(false)
}

include(":app")