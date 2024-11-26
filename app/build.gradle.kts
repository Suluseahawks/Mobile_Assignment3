plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

android {
    namespace = "com.example.mobileassignment3"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.mobileassignment3"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation(libs.androidx.core.ktx)  // Core KTX for Android extensions
    implementation(libs.androidx.lifecycle.runtime.ktx)  // Lifecycle runtime KTX
    implementation(libs.androidx.activity.compose)  // Compose integration with Activity
    implementation(platform(libs.androidx.compose.bom))  // Compose BOM for version management
    implementation(libs.androidx.ui)  // Jetpack Compose UI
    implementation(libs.androidx.ui.graphics)  // Graphics support for Compose
    implementation(libs.androidx.ui.tooling.preview)  // Preview tooling for Compose
    implementation(libs.androidx.material3)  // Material3 for Compose
    testImplementation(libs.junit)  // JUnit for testing
    androidTestImplementation(libs.androidx.junit)  // JUnit for Android testing
    androidTestImplementation(libs.androidx.espresso.core)  // Espresso for UI testing
    androidTestImplementation(platform(libs.androidx.compose.bom))  // Compose BOM for tests
    androidTestImplementation(libs.androidx.ui.test.junit4)  // UI tests for Compose
    debugImplementation(libs.androidx.ui.tooling)  // Debug tooling for Compose
    debugImplementation(libs.androidx.ui.test.manifest)  // UI test manifest for Compose
}


