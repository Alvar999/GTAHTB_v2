#if defined _INC_od_stdio 
    #endinput 
#endif 
#define _INC_od_stdio 

new File:stdin; 
new File:stdout; 

OD_STDIO_OnGameModeInit() { 
    stdin = fopen("CON", io_read); 
    stdout = fopen("CON", io_write); 
} 

OD_STDIO_OnGameModeExit() { 
    fclose(stdin); 
    fclose(stdout); 
} 

stock OD_STDIO_Flush() { 
    fclose(stdout); 
    stdout = fopen("CON", io_write); 
} 

stock OD_STDIO_CarriageReturn() { 
    fwrite(stdout, "\r"); 
} 

stock OD_STDIO_NewLine() { 
    fwrite(stdout, "\n"); 
} 

stock OD_STDIO_Write(str[]) { 
    fwrite(stdout, str); 
} 

stock OD_STDIO_Read(str[], size = sizeof (str)) { 
    // Press enter first. 
    fread(stdin, str, size); 
}  