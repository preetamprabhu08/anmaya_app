import java.util.Properties
import java.io.FileInputStream
import java.io.File

val keystoreProperties = Properties()
// Use direct file path to android/key.properties
val keystorePropertiesFile = File(rootProject.projectDir, "key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
    println("Loaded keystore properties from ${keystorePropertiesFile.absolutePath}")
} else {
    println("Warning: ${keystorePropertiesFile.absolutePath} not found")
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Add the Google services Gradle plugin
    id("com.google.gms.google-services")
}

android {
    namespace = "com.anmaya.edtech"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.anmaya.edtech"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"]?.toString() ?: "anmaya-key"
            keyPassword = keystoreProperties["keyPassword"]?.toString() ?: "preetam"
            storeFile = file("anmaya-release-key.jks")
            storePassword = keystoreProperties["storePassword"]?.toString() ?: "preetam"
        }
    }

    buildTypes {
        release {
            // Updated to use the release signing config
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}


dependencies {
  // Import the Firebase BoM
  implementation(platform("com.google.firebase:firebase-bom:33.14.0"))


  // TODO: Add the dependencies for Firebase products you want to use
  // When using the BoM, don't specify versions in Firebase dependencies
  implementation("com.google.firebase:firebase-analytics")


  // Add the dependencies for any other desired Firebase products
  // https://firebase.google.com/docs/android/setup#available-libraries
}