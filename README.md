# WhiteDragon AutoLaunch

Windows 上的非官方 Codex 启动器。它可在启动已安装的 Codex 桌面客户端时播放本地 MP4，并将动画画面衔接到客户端窗口。默认配置使用 4K 播放尺寸和全屏模式。

## 从源码运行

需要 64 位 Windows、系统自带的 .NET Framework 4.x/WPF 和 Windows PowerShell，以及能够正常启动的 Codex 桌面客户端。播放还需要 Windows 的媒体组件。

在项目根目录执行：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\build.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Import-Animation.ps1 -VideoPath "D:\Animations\startup.mp4"
.\build\DragonCodexBoot\DragonCodexBoot.exe
```

构建脚本会运行配置和窗口几何自测，并保留输出目录里已有的配置。公开配置的动画时间点与画面坐标需要按自备视频调整。请修改输出目录的 launcher.json 中的 HoldAt、TransitionStart、TransitionEnd 和 ScreenFrames。若客户端安装方式不同，可修改 AppLaunch 和进程匹配项。Diagnose-Codex.cmd 可查看本机识别结果。

## 快捷方式与本地数据

AutoReplaceEntrypoints 和 ScanAllLocalDrives 默认关闭。手动运行 Rescan-Entrypoints.cmd 可执行入口扫描与替换。运行 Restore-Original-Entrypoints.cmd 可尝试从备份恢复。分享诊断输出前请检查其中的本机路径和用户名。

## 许可与声明

项目沿用原有 MIT 许可证，详见 [LICENSE](LICENSE)。产品名称、平台依赖与自备素材的权利说明见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
