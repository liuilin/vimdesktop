## ![icon](Doc/Images/vimdesktop_32.jpg) VimDesktop

让所有 Windows 桌面程序拥有 Vim 操作风格的辅助工具。

### Quickstart

参考 Doc 文件夹，以及 `./Doc/wiki/如何写插件.md`

在 `./Plugins` 目录下新增目录进行增减插件，然后直接重启 VimD，会自动配置新插件 `./Conf/vimd.ini` 或 `./Plugins/Plugin` 

> 增加插件时不需要更改 `./Conf/vimd.ini` 或 `./Plugins/Plugin`。如需 `启用/禁用` 才需要将文件 `./Conf/vimd.ini` 中将 `[plugins]` 列进行插件 `启用/禁用`

### 链接

[详细介绍](https://github.com/goreliu/vimdesktop/wiki)

[Introduction](https://github.com/goreliu/vimdesktop/wiki/VimDesktop-Introduction)

[下载地址](https://github.com/goreliu/vimdesktop/releases/latest)

[文档首页](https://github.com/goreliu/vimdesktop/wiki)

[TC 快捷键列表](https://github.com/goreliu/vimdesktop/wiki/TC%E5%BF%AB%E6%8D%B7%E9%94%AE%E5%88%97%E8%A1%A8)

[API 列表](https://github.com/goreliu/vimdesktop/wiki/API%E5%88%97%E8%A1%A8)

[更新历史](https://github.com/goreliu/vimdesktop/wiki/HISTORY)

### VimDesktop 历史

VimDesktop 的前身是 [linxinhong](http://git.oschina.net/linxinhong) 的 ViATc （现已停止更新）：[github地址](https://github.com/linxinhong/ViATc) [sourceforge地址](https://sourceforge.net/p/viatc/home/%E4%B8%BB%E9%A1%B5/)

之后 [linxinhong](http://git.oschina.net/linxinhong) 将其升级为 [VimDesktop 1](https://github.com/victorwoo/vimdesktop)，该版本由 [linxinhong](http://git.oschina.net/linxinhong)、[victorwoo](https://github.com/victorwoo)、[wideweide](https://github.com/wideweide) 等人协同开发。

再之后 [linxinhong](http://git.oschina.net/linxinhong) 又将其升级为 [VimDesktop 2](http://git.oschina.net/linxinhong/VimDesktop)，2版本的核心文件和1版本相比改动较大，配置文件格式也有所不同。

目前 [linxinhong](http://git.oschina.net/linxinhong) 将主要精力放在 [QuickZ](http://git.oschina.net/linxinhong/QuickZ) 上， [VimDesktop 2](http://git.oschina.net/linxinhong/VimDesktop) 已有较长时间没有更新。

### 此版本 VimDesktop 的历史和缘由

我 2016 年 1 月接触到的 VimDesktop，当时在网上搜到了两个版本的 VimDesktop，如上所述。我分别试用后感觉 [VimDesktop 1](https://github.com/victorwoo/vimdesktop) 版本的好用些，主要是 `TotalCommander_Dialog` 插件很有用，配置文件也更方便些，当时并未考虑过修改代码。但使用过程中慢慢发现一些问题，或者有功能缺失，改了很多代码。修改过程中，发现这个版本的核心文件 `lib/vimcore.ahk` 缺陷比较多，功能也相对薄弱，而 [VimDesktop 2](http://git.oschina.net/linxinhong/VimDesktop) 的`lib/class_vim.ahk` 是 `lib/vimcore.ahk` 的升级版，功能更强大，缺陷也少些。于是改用 [VimDesktop 2](http://git.oschina.net/linxinhong/VimDesktop) 的部分核心文件，而插件部分还是沿用之前的代码，除了必要的兼容性改动。

此版本包含 [VimDesktop 1](https://github.com/victorwoo/vimdesktop) 和 [VimDesktop 2](http://git.oschina.net/linxinhong/VimDesktop) 的全部功能。

2020 年起，我不再发布新版本，不再保证原有功能继续保留，不再保证配置的向后兼容性，不再回答任何功能相关问题，不再维护文档，我会根据自己的需求随意修改代码，请不要随意更新。因为很多陈旧代码的功能我并不需要，也无力测试，放在那里会让软件的维护变得十分困难，所以我已经几年时间没有大改了。为了让这个软件继续活下去（即使只有我一个人用），我必须放弃向后兼容的包袱，大刀阔斧地修改。另外我已经用 [Double Commander](https://doublecmd.sourceforge.io/) 替代了 [Total Commander](https://www.ghisler.com/)，所以不再维护 TC 插件（但不会删除代码）。而我写的 DC 插件，依赖 DC 本身的代码修改和配置定制，仅供自用。

如果有人想维护该软件的公共版本，可以通过 ly50247@126.com 联系我。
