#if defined _INC_od_scroll_text 
    #endinput 
#endif 
#define _INC_od_scroll_text 

#include <od_stdio> 

stock OD_SCROLL_Static(text[], offset, width, prefix[] = "", suffix[] = "") { 
    OD_STDIO_CarriageReturn(); 
    OD_STDIO_Write(prefix); 
    new length = strlen(text); 
    static spaces[] = "                                "; 
    new start = clamp(offset, 0, length); 
    new end = clamp(offset + width, 0, length); 
    if (offset < 0) { 
        new padding = clamp(-offset, 0, width); 
        for (new i = 0; i < padding; i = i + 32) { 
            OD_STDIO_Write(spaces[clamp(32 - (padding - i), 0, 32)]); 
        } 
    } 
    new ch = text[end]; 
    text[end] = '\0'; 
    OD_STDIO_Write(text[start]); 
    text[end] = ch; 
    for (new i = end - offset; i < width; i = i + 32) { 
        OD_STDIO_Write(spaces[clamp(32 - (width - i), 0, 32)]); 
    } 
    OD_STDIO_Write(suffix); 
    OD_STDIO_Flush(); 
} 

stock OD_SCROLL_Dynamic(text[], width, time, prefix[] = "", suffix[] = "") { 
    new end = GetTickCount(); 
    new start = -width; 
    new length = strlen(text); 
    for ( ; ; ) { 
        for (new i = start; i <= length; ++i) { 
            OD_SCROLL_Static(text, i, width, prefix, suffix); 
            end = end + time; 
            while (GetTickCount() < end) { 
            } 
        } 
    } 
}  