#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Rainer Christian Bjoern Herold

# Libraries
from Resources.Python.Standard_Operations.Libraries import DEVNULL, join, osname, run, sleep, stdout, system, walk
from Resources.Python.Standard_Operations.Colors    import Colors

# Classes
class Standard:
    def Stdout_Output(Text_Array):
        for char in Text_Array:
            stdout.write(char)
            stdout.flush()
            sleep(0.008)

    def Initials():
        if (osname == 'nt'): system('cls')
        else:                system('clear')
        Header = """💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀
💀\t\t\t\t\t\t\t\t💀
💀\t\t           """+Colors.UNDERLINE+"Yggdrasil"+Colors.RESET+"""\t\t\t\t💀
💀\t\t\t  """+Colors.ORANGE+"Version "+Colors.CYAN+"0.9d"+Colors.RESET+"""    \t\t\t💀
💀\t\t"""+Colors.CYAN+"Rainer Christian Bjoern Herold"+Colors.RESET+"""\t\t\t💀
💀\t\t\t\t\t\t\t\t💀
💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀💀\n\n
"""
        Standard.Stdout_Output(Header)

    def Carriage_Remove(File_Path):
        Array_Codecs = ['ascii','big5','big5hkscs','cp037','cp273','cp424','cp437','cp500','cp720','cp737','cp775','cp850','cp852','cp855',
                        'cp856','cp857','cp858','cp860','cp861','cp862','cp863','cp864','cp865','cp866','cp869','cp874','cp875','cp932',
                        'cp949','cp950','cp1006','cp1026','cp1125','cp1140','cp1250','cp1251','cp1252','cp1253','cp1254','cp1255','cp1256',
                        'cp1257','cp1258','euc_jp','euc_jis_2004','euc_jisx0213','euc_kr','gb2312','gbk','gb18030','hz','iso2022_jp',
                        'iso2022_jp_1','iso2022_jp_2','iso2022_jp_2004','iso2022_jp_3','iso2022_jp_ext','iso2022_kr','latin_1','iso8859_2',
                        'iso8859_3','iso8859_4','iso8859_5','iso8859_6','iso8859_7','iso8859_8','iso8859_9','iso8859_10','iso8859_11',
                        'iso8859_13','iso8859_14','iso8859_15','iso8859_16','johab','koi8_r','koi8_t','koi8_u','kz1048','mac_cyrillic',
                        'mac_greek','mac_iceland','mac_latin2','mac_roman','mac_turkish','ptcp154','shift_jis','shift_jis_2004',
                        'shift_jisx0213','utf_32','utf_32_be','utf_32_le','utf_16','utf_16_be','utf_16_le','utf_7','utf_8_sig']

        for root, _, files in walk(File_Path, topdown=False):
            for file in files:
                if (not file.endswith('.ps1')  and
                    not file.endswith('.py')   and
                    not file.endswith('.jpg')  and
                    not file.endswith('.jpeg') and
                    not file.endswith('.png')  and
                    not '.git' in root         and
                    not '__pycache__' in root):
                        try:
                            with open(join(root, file), 'r', encoding='utf-8') as f:
                                Temp_Text = f.read().replace('\r\n', '\n')
                        except UnicodeDecodeError:
                            print ("The file "+Colors.RED+f"{join(root, file)}"+Colors.RESET+" was not written in 'utf-8'.\n\nthe tool is now trying to get the correct format.")
                            for Codec in Array_Codecs:
                                try:
                                    with open(join(root, file), 'r', encoding=Codec, errors='ignore') as f:
                                        Temp_Text = f.read().replace('\r\n', '\n')
                                    break
                                except UnicodeDecodeError: pass
                        finally:
                            try:
                                with open(join(root, file), 'w') as f:
                                    f.write(Temp_Text)
                            except:
                                print (Colors.RED+f"It was not possible to convert any kind of data.\n\nPlease use for custom files 'utf-8' as standard encode and try it again.")

    def Check_Permissions(File_Path):
        def Permission_Change(File): run(['sudo','chmod','+x',File], stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL)

        for root, _, files in walk(File_Path, topdown=False):
            for file in files:
                if (file.endswith('.py')):   Permission_Change(join(root, file))
                elif (file.endswith('.sh')): Permission_Change(join(root, file))
