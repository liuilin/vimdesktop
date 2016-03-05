﻿VimDConfig:
    vim.SetPlugin("VimDConfig", "Array", "0.1", "VimDesktop的配置界面")
    vim.SetAction("<vc_plugin>", "显示 VimDesktop 插件信息")
    vim.SetAction("<vc_keymap>", "显示 VimDesktop 热键信息")
return

<vc_plugin>:
{
    GUI, VimDConfig_plugin:Destroy
    GUI, VimDConfig_plugin:Default
    GUI, VimDConfig_plugin:Font, s10, Microsoft YaHei
    GUI, VimDConfig_plugin:Add, ListView, x10 y10 w150 h400 grid altsubmit gVimDConfig_LoadActions, 插件
    for plugin, obj in vim.pluginlist
        LV_Add("", plugin)
    GUI, VimDConfig_plugin:Add, ListView, x170 y10 w650 h400 grid altsubmit, 序号|动作|描述
    LV_ModifyCol(1, "center")
    LV_ModifyCol(2, "left 250")
    LV_ModifyCol(3, "left 400")
    GUI, VimDConfig_plugin:Show
    return
}

VimDConfig_LoadActions:
{
    If A_GuiEvent = I
    {
        if not InStr(ErrorLevel, "S", true)
        {
            return
        }

        GUI, VimDConfig_plugin:ListView, sysListview321
        LV_GetText(plugin, A_EventInfo)
        GUI, VimDConfig_plugin:Default
        GUI, VimDConfig_plugin:ListView, sysListview322
        idx := 1
        LV_Delete()
        for action, type in vim.ActionFromPlugin
        {
            If type = %plugin%
            {
                Desc := vim.GetAction(action)
                LV_Add("", idx, action, Desc.Comment)
                idx++
            }
        }
    }
    return
}

<vc_keymap>:
{
    menu, VimDConfig_keymap_menu, add
    ;menu, VimDConfig_keymap_menu, deleteall
    menu, VimDConfig_keymap_menu, add, &Exit, VimDConfig_keymap_exit

    GUI, VimDConfig_keymap:Destroy
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:Font, s10, Microsoft YaHei

    GUI, VimDConfig_keymap:Add, GroupBox, x10 y10 w300 h270, 窗口(&Q)
    GUI, VimDConfig_keymap:Add, ListBox, x20 y36 w180 R12 center gVimDConfig_keymap_loadmodelist

    GUI, VimDConfig_keymap:Add, GroupBox, x10 y290  w200 h140, 模式(&M)
    GUI, VimDConfig_keymap:Add, ListBox, x20 y316  w180 R5 center gVimDConfig_keymap_loadhotkey

    GUI, VimDConfig_keymap:Add, GroupBox, x225 y10 w650 h420, 热键定义（双击进入对应文件，右键双击修改键映射）(&V)
    GUI, VimDConfig_keymap:Add, Listview, glistview x235 y36 w630 h380 grid, 热键|动作|描述
    GUI, VimDConfig_keymap:Font, s12, Microsoft YaHei
    GUI, VimDConfig_keymap:Add, Text, x230 h25, 搜索：
    GUI, VimDConfig_keymap:Font, s10, Microsoft YaHei
    GUI, VimDConfig_keymap:Add, Edit, v_search x+10 w120 h25
    GUI, VimDConfig_keymap:Add, Button, gsearch_keymap x+15 w50 h25 Default, 搜索

    LV_ModifyCol(1, "left 100")
    LV_ModifyCol(2, "left 250")
    LV_ModifyCol(3, "left 400")

    VimDConfig_keymap_loadwinlist()
    VimDConfig_keymap_loadhotkey(VimDConfig_keymap_loadmodelist(thiswin))

    GUI, VimDConfig_keymap:show
    return
}

VimDConfig_keymap_exit:
{
    GUI, VimDConfig_keymap:Destroy
    return
}

VimDConfig_keymap_loadwinlist()
{
    global vim
    list := "|全局"
    GUI, VimDConfig_keymap:Default
    for win, obj in vim.WinList {
        if vim.ExcludeWinList[win]{
            continue
        }
        list .= "|" win
    }
    GuiControl, , ListBox1, %list%
}

VimDConfig_keymap_loadmodelist:
    VimDConfig_keymap_loadmodelist()
    GUI, VimDConfig_keymap:Default
    LV_delete()
    GuiControl, Choose, ListBox2, |normal
return

VimDConfig_keymap_loadmodelist(win = "")
{
    global vim
    GUI, VimDConfig_keymap:Default
    If not strlen(win)
        ControlGet, win, Choice, , ListBox1
    If win = 全局
        winObj := vim.GetWin()
    Else
        winObj := vim.GetWin(win)
    for mode, obj in winobj.modeList
        mlist .= "|" mode
    GuiControl, , ListBox2, %mlist%
    return win
}

VimDConfig_keymap_loadhotkey:
    GUI, VimDConfig_keymap:Default
    ControlGet, win, Choice, , ListBox1
    win := RegExMatch(win, "^全局$") ? "" : win
    ControlGet, mode, Choice, , ListBox2
    VimDConfig_keymap_loadhotkey(win, mode)
return

VimDConfig_keymap_loadhotkey(win, mode = "")
{
    global vim
    If strlen(mode)
    {
        winObj  := vim.GetWin(win)
        modeobj := winObj.modeList[mode]
    }
    Else
        modeobj := vim.GetMode(win)
    GUI, VimDConfig_keymap:Default
    LV_delete()
    for key, i in modeobj.keymapList
    {
        ; Type = 1 : Function
        if (vim.GetAction(i).Type = 1)
        {
            ActionDescList := vim.GetAction(i).Comment
            actionDesc := StrSplit(%ActionDescList%[key], "|")
            LV_ADD("", Key, actionDesc[1], actionDesc[2])
        }
        else
        {
            LV_Add("", Key, i, vim.GetAction(i).Comment)
        }
    }
}

listview:
    if A_GuiEvent = DoubleClick
    {
        ;~ ToolTip You double-clicked row number %A_EventInfo%.
        LV_GetText(SelectedAction, A_EventInfo, 2)
        LV_GetText(SelectedDesc, A_EventInfo, 3)
        SearchFileForEdit(SelectedAction, SelectedDesc, false)
    }
    else if A_GuiEvent = R
    {
        LV_GetText(SelectedAction, A_EventInfo, 2)
        LV_GetText(SelectedDesc, A_EventInfo, 3)
        SearchFileForEdit(SelectedAction, SelectedDesc, true)
    }

return

 
ToMatch(str)
{
    str := RegExReplace(str,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
    Return RegExReplace(str,"\s","\s")
}

SearchFileForEdit(Action, Desc, EditKeyMapping)
{
    if (Action = "key" || Action = "run" || EditKeyMapping)
    {
        SearchLine := "=" Action

        if (Action = "key" || Action = "run") {
            SearchLine := Action "|" Desc
        }

        Loop, Read, %A_ScriptDir%\vimd.ini
        {
            if (InStr(A_LoopReadLine, SearchLine))
            {
                EditFile(A_ScriptDir "\vimd.ini", A_Index)
                return
            }
        }

        EditFile(A_ScriptDir "\vimd.ini")
        return
    }

    label := Action ":"
    funcMatch := ToMatch(Action) "\s*\(\)"
    FileEncoding,
    Loop, %A_ScriptDir%\plugins\*.ahk, , 1
    {
        Loop, Read, %A_LoopFileFullPath%
        {
            if (A_LoopReadLine = label || RegExMatch(A_LoopReadLine, funcMatch))
            {
                EditFile(A_LoopFileFullPath, A_Index)
                return
            }
        }
    }

    Loop, %A_ScriptDir%\core\*.ahk, , 1
    {
        Loop, Read, %A_LoopFileFullPath%
        {
            if (A_LoopReadLine = label || RegExMatch(A_LoopReadLine, funcMatch))
            {
                EditFile(A_LoopFileFullPath, A_Index)
                return
            }
        }
    }
}

EditFile(editPath, line := 1)
{
    editorArgs := {}
    editorArgs["notepad"] := "/g $line $file"
    editorArgs["notepad2"] := "/g $line $file"
    editorArgs["sublime_text"] := "$file:$line"
    editorArgs["vim"] := "+$line $file"
    editorArgs["gvim"] := "--remote-silent-tab +$line $file"
    editorArgs["everedit"] := "-n$line $file"
    editorArgs["notepad++"] := "-n$line $file"
    editorArgs["EmEditor"] := "-l $line $file"
    editorArgs["uedit32"] := "$file/$line"
    editorArgs["Editplus"] := "$file -cursor $line"
    editorArgs["textpad"] := "$file($line)"
    editorArgs["pspad"] := "$file /$line"
    editorArgs["ConTEXT"] := "$file /g1:$line"
    editorArgs["scite"] := "$file -goto:$line"

    Global editor
    
    If not FileExist(editor)
    {
        MsgBox, 请配置 vimd.ini 中 [config] 中的 editor ！
        return
    }

    ; 根据编辑器 exe 名称获取打开参数
    SplitPath, editor, , , OutExtension, OutNameNoExt
    args := editorArgs[OutNameNoExt]
    StringReplace, args, args, $line, %line%
    StringReplace, args, args, $file, "%editPath%"
    target := editor " " args
    if (OutExtension = "sh")
    {
        target := "sh.exe " target
    }

    run, %target%
}

search_keymap:
    Gui Submit, nohide
    GuiControlGet, OutputVar, , _search
    if OutputVar =
    {
        LV_Delete() ; 清理不掉，第二次加载后，都成了重复的了，不知道怎么处理
        LV_ModifyCol(1, "left 100")
        LV_ModifyCol(2, "left 250")
        LV_ModifyCol(3, "left 400")

        VimDConfig_keymap_loadHotkey(VimDConfig_keymap_loadmodelist(thiswin))
        return
    }

    Loop % LV_GetCount()
    {
        LV_GetText(Text_1, A_Index, 1)
        LV_GetText(Text_2, A_Index, 2)
        LV_GetText(Text_3, A_Index, 3)
        if InStr(Text_1, OutputVar) or InStr(Text_2, OutputVar) or InStr(Text_3, OutputVar) ;搜索全部
        {
            LV_GetText(Text_1, A_Index,1)
            LV_GetText(Text_2, A_Index,2)
            LV_GetText(Text_3, A_Index,3)
            match = %Text_1%---%Text_2%---%Text_3%
            zmatch .= match "`n"
        }
    }

    text := StrSplit(zmatch, "`n")

    LV_Delete() ; 清理不掉，第二次加载后，都成了重复的了，不知道怎么处理
    GuiControl, -Redraw, listview ; 重新启用重绘 (上面把它禁用了)
    for k,v in text
    {
        if v =
            continue
        list := StrSplit(v, "---")
        LV_Add("", list[1], list[2], list[3])
    }
    GuiControl, +Redraw, listview ; 重新启用重绘 (上面把它禁用了)

    match =
    zmatch =
    OutputVar =
return