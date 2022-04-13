# package_by_walle

Packaging Android apps through multiple channels(based on walle)

## Getting Started

`参考example目录`

1. 在 android/build.gradle 添加代码

```
buildscript {
    repositories {
        maven {
            url 'https://maven.aliyun.com/repository/jcenter'
        }
        maven {
            url 'https://maven.aliyun.com/repository/google'
        }
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:4.1.0'
        // 添加这一句
        classpath 'com.meituan.android.walle:plugin:1.1.7'
    }
}
```

2. 在 android/app/build.gradle 最后添加

```
// 添加以下代码
apply plugin: 'walle'

walle {
// 指定渠道包的输出路径
apkOutputFolder = new File("${project.rootDir}/output/channels/")
// 定制渠道包的APK的文件名称
apkFileNameFormat = '${appName}-${packageName}-${channel}-${buildType}-v${versionName}-${versionCode}-${buildTime}.apk'
// 渠道配置文件
channelFile = new File("${project.getProjectDir()}/channel")
}
```

3. 根据第二步的渠道配置文件创建channel文件

4. 切换到android目录，运行`gradlew clean assembleReleaseChannels --stacktrace`

## 问题

1. Execution failed for task ':app:lintVitalRelease'

```
android {
    compileSdkVersion 30
    
    // 添加配置
    lintOptions {
        checkReleaseBuilds false
        abortOnError false
    }
    
    // ...
}
```