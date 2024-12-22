plugins {
    kotlin("jvm") version "1.9.23"
    id("org.jetbrains.kotlin.plugin.serialization") version "2.0.21"
    `maven-publish`
}

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
    implementation("io.ktor:ktor-client-core:3.0.0")
    implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.7.1")
    implementation ("com.fasterxml.jackson.module:jackson-module-kotlin:2.18.2")
}

tasks.test {
    useJUnitPlatform()
}

kotlin {
    jvmToolchain(21)
}
publishing {
    repositories {
        maven {
            name = "MaestriHub"
            url = uri("https://maven.pkg.github.com/MaestriHub/shared-modules")
            credentials {
                username = "name"
                password = "password"
            }
        }
    }
    publications {
        register<MavenPublication>("gpr") {
            from(components["kotlin"])
            groupId = "app.maestri"
            version = "1.1.29"
            artifactId = "shared"
        }
    }
}