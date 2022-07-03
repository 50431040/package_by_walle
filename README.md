# package_by_walle

flutter多渠道打包（基于[walle](https://github.com/Meituan-Dianping/walle)）

## 安装

`package_by_walle: 1.0.2`

## 注意

**经过线上测试，存在小部分机型获取不到渠道的情况，请慎重使用**

## 配置

> 请务必按照步骤一步步配置，参考example目录

1. 添加`walle`插件依赖：在`android/build.gradle`文件中添加

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

2. walle打包配置：在`android/app/build.gradle`文件最后添加。（channelFile 和 configFile 任选其一）

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

3. 在第二步中选择创建一种配置方式，然后创建对应的文件。（参考example/android目录）

4. 命令行切换到android目录，运行打包命令

- 多渠道打包：`gradlew clean assembleReleaseChannels --stacktrace`
- 单个渠道打包：`gradlew clean assembleReleaseChannels -PchannelList=meituan`

## 使用

```dart
// 获取渠道号
String channel = await PackageByWalle.getPackingChannel ?? "test";

// 获取额外打包参数（configFile文件中配置）
Map info = await PackageByWalle.getPackingInfo;
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

3. 其他问题请提issue