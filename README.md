# package_by_walle

Packaging Android apps through multiple channels(based on walle)
flutter多渠道打包（基于[walle](https://github.com/Meituan-Dianping/walle)）

## 打包配置

`参考example目录`

1. 在 android/build.gradle 添加代码

```
buildscript {
    repositories {
        // 不加这个会出现找不到插件的报错
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
// 1. channelFile形式（渠道配置文件）
channelFile = new File("${project.getProjectDir()}/channel")
// 2. 渠道&额外信息配置文件，与channelFile互斥
// 此配置项与channelFile功能互斥，开发者在使用时选择其一即可，两者都存在时configFile优先执行。
configFile = new File("${project.rootDir}/config.json")
}
```

3. 在第二步中选择创建一种配置方式，然后创建对应的文件。（具体路径及文件参考example目录）

4. 切换到android目录，运行打包命令

- 多渠道打包：`gradlew clean assembleReleaseChannels --stacktrace`
- 单个渠道打包：`gradlew clean assembleReleaseChannels -PchannelList=meituan`

## 本地调试

```dart
String channel = await PackageByWalle.getPackingChannel ?? "test";
```

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

2. Could not find com.meituan.android.walle:plugin:1.1.7.

```
// 在 android/build.gradle 添加代码
maven {
    url 'https://maven.aliyun.com/repository/jcenter'
}
maven {
    url 'https://maven.aliyun.com/repository/google'
}
```