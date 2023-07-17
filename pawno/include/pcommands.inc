/* Players Commands */

CMD:window(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        new window, driver, passenger, backleft, backright;
        new vehicleid = GetPlayerVehicleID(playerid);
        if(!vehicleid) return 1;
        new loc = GetPlayerVehicleSeat(playerid);
        GetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, backright);//i added at here after check vehicleid
        if(sscanf(params, "d", window))
        {
            new string[100];
            format(string,sizeof(string),"{B8DBFF}Windows status: %d %d %d %d", driver, passenger, backleft, backright);
            SendClientMessage(playerid, 0xFFFFFFFF,"{FFFFFF}Syntax: {FFFFFF}/window <1-4>");
            SendClientMessage(playerid, 0xFFFFFFFF,string);
            return 1;
        }
        switch(window){
            case 1:{
                if(loc == 0)
                {
                    if(driver == 0)
                    {
                        SetVehicleParamsCarWindows(vehicleid, 1, passenger, backleft, backright);//here
                    }
                    else
                    {
                        SetVehicleParamsCarWindows(vehicleid, 0, passenger, backleft, backright);//here
                    }
                }
            }
            case 2:{
                if(loc == 0 || loc == 1)
                {
                    if(passenger == 0)
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, 1, backleft, backright);//here
                    }
                    else
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, 0, backleft, backright);//here
                    }
                }
            }
            case 3:{
                if(loc == 0 || loc == 2)
                {
                    if(backleft == 0)
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, passenger, 1, backright);//here
                    }
                    else
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, passenger, 0, backright);//here
                    }
                }
            }
            case 4:{
                if(loc == 0 || loc == 3)
                {
                    if(backright == 0)
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 1);//here
                    }
                    else
                    {
                        SetVehicleParamsCarWindows(vehicleid, driver, passenger, backleft, 0);//here
                    }
                }
            }
            default:{
                return SendClientMessage(playerid, 0xFFFFFFFF,"{FFFFFF}Syntax: {FFFFFF}/window <1-4>");
            }
        }
    }
    return 1;
}
